CMAKE ?= cmake
# For local development, assuming https://github.com/sourcemeta/registry
# is cloned and built as a sibling directory of this repository
REGISTRY ?= ../registry/build/dist/bin
BUILD ?= ./build
OUTPUT ?= $(BUILD)/registry

ifeq ($(shell uname), Darwin)
LDD ?= otool -L
else
LDD ?= ldd
endif

.PHONY: all
all: prepare index
	$(REGISTRY)/sourcemeta-registry-server $(OUTPUT)

.PHONY: prepare
prepare:
	$(LDD) $(REGISTRY)/sourcemeta-registry-index
	$(LDD) $(REGISTRY)/sourcemeta-registry-server

.PHONY: index
index: configuration.json
	$(REGISTRY)/sourcemeta-registry-index $< $(OUTPUT)

.PHONY: clean
clean:
	$(CMAKE) -E rm -R -f $(BUILD)
