all: local
# For local development, assuming https://github.com/sourcemeta/registry 
# is cloned and built as a sibling directory of this repository
local: .always
	../registry/build/dist/bin/sourcemeta-registry-index configuration.json ./build
	../registry/build/dist/bin/sourcemeta-registry-server ./build
.always:
