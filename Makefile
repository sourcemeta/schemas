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
all: dev

.PHONY: prepare
prepare:
	@echo "Running prepare steps"
	$(LDD) $(REGISTRY)/sourcemeta-registry-index
	$(LDD) $(REGISTRY)/sourcemeta-registry-server

.PHONY: dev
dev: configuration.json prepare
	$(REGISTRY)/sourcemeta-registry-index $< $(OUTPUT)
	$(REGISTRY)/sourcemeta-registry-server $(OUTPUT)

.PHONY: clean
clean:
	$(CMAKE) -E rm -R -f $(BUILD)
