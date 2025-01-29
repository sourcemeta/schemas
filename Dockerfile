FROM ghcr.io/sourcemeta/registry-ee:main AS builder
RUN apt-get --yes update && apt-get install --yes --no-install-recommends make
COPY configuration.json /app/configuration.json
COPY vendor /app/vendor
COPY Makefile /app/Makefile
RUN make -C /app prepare REGISTRY=/usr/bin
RUN sourcemeta-registry-index /app/configuration.json /app/index

FROM scratch
COPY --from=builder /usr/bin/sourcemeta-registry-server \
  /usr/bin/sourcemeta-registry-server
COPY --from=builder /usr/share/sourcemeta/registry \
  /usr/share/sourcemeta/registry
COPY --from=builder /app/index /app/index

# Linker
COPY --from=builder /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=builder /etc/ld.so.cache /etc/ld.so.cache
# Based on an ldd(1) output on Debian Bookworm
COPY --from=builder /lib/x86_64-linux-gnu/libstdc++.so.6 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/
