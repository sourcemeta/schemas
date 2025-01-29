NODE ?= node
MKDIR ?= mkdir
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

define geojson_prepare
$(BUILD)/geojson-$(1)/%.json: vendor/geojson-$(1)/bin/format.js vendor/geojson-$(1)/src/schema/%.js
	$(MKDIR) -p $$(dir $$@) && $(NODE) $$< $$(word 2,$$^) > $$@
endef

$(eval $(call geojson_prepare,1-0-5))
$(eval $(call geojson_prepare,1-0-4))
$(eval $(call geojson_prepare,1-0-3))
$(eval $(call geojson_prepare,1-0-2))
$(eval $(call geojson_prepare,1-0-1))
$(eval $(call geojson_prepare,1-0-0))

.PHONY: prepare
prepare: \
	$(patsubst vendor/geojson-1-0-5/src/schema/%.js,$(BUILD)/geojson-1-0-5/%.json,$(wildcard vendor/geojson-1-0-5/src/schema/*.js)) \
	$(patsubst vendor/geojson-1-0-4/src/schema/%.js,$(BUILD)/geojson-1-0-4/%.json,$(wildcard vendor/geojson-1-0-4/src/schema/*.js)) \
	$(patsubst vendor/geojson-1-0-3/src/schema/%.js,$(BUILD)/geojson-1-0-3/%.json,$(wildcard vendor/geojson-1-0-3/src/schema/*.js)) \
	$(patsubst vendor/geojson-1-0-2/src/schema/%.js,$(BUILD)/geojson-1-0-2/%.json,$(wildcard vendor/geojson-1-0-2/src/schema/*.js)) \
	$(patsubst vendor/geojson-1-0-1/src/schema/%.js,$(BUILD)/geojson-1-0-1/%.json,$(wildcard vendor/geojson-1-0-1/src/schema/*.js)) \
	$(patsubst vendor/geojson-1-0-0/src/schema/%.js,$(BUILD)/geojson-1-0-0/%.json,$(wildcard vendor/geojson-1-0-0/src/schema/*.js))
	$(LDD) $(REGISTRY)/sourcemeta-registry-index
	$(LDD) $(REGISTRY)/sourcemeta-registry-server

.PHONY: index
index: configuration.json
	$(REGISTRY)/sourcemeta-registry-index $< $(OUTPUT)

.PHONY: clean
clean:
	$(CMAKE) -E rm -R -f $(BUILD)
