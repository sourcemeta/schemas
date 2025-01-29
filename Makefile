CMAKE ?= cmake
# For local development, assuming https://github.com/sourcemeta/registry
# is cloned and built as a sibling directory of this repository
REGISTRY ?= ../registry/build/dist/bin
BUILD ?= ./build
OUTPUT ?= $(BUILD)/registry

.PHONY: all
all: dev

.PHONY: dev
dev: configuration.json
	$(REGISTRY)/sourcemeta-registry-index $< $(OUTPUT)
	$(REGISTRY)/sourcemeta-registry-server $(OUTPUT)

.PHONY: clean
clean:
	$(CMAKE) -E rm -R -f $(BUILD)
