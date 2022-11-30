SHELL = /bin/sh

BUILD_DIR_DEBUG = build-debug
BUILD_DIR_RELEASE = build-release
TARGET_DEBUG = $(BUILD_DIR_DEBUG)/src/template
TARGET_RELEASE = $(BUILD_DIR_RELEASE)/src/template

all: $(TARGET_DEBUG) $(TARGET_RELEASE)

run-debug: $(BUILD_DIR_DEBUG)
	$(MAKE) -C $(BUILD_DIR_DEBUG)
	./$(BUILD_DIR_DEBUG)/src/template

run-release: $(TARGET_RELEASE)
	$(MAKE) -C $(BUILD_DIR_RELEASE)
	./$(BUILD_DIR_RELEASE)/src/template

$(TARGET_DEBUG): $(BUILD_DIR_DEBUG)
	$(MAKE) -C $(BUILD_DIR_DEBUG)

$(TARGET_RELEASE): $(BUILD_DIR_RELEASE)
	$(MAKE) -C $(BUILD_DIR_RELEASE)

configure:
	autoreconf --install

# create release archive in build directory
dist: $(BUILD_DIR_RELEASE)
	$(MAKE) -C $(BUILD_DIR_RELEASE) dist

# validate correctness of release archive
distcheck: $(BUILD_DIR_RELEASE)
	$(MAKE) -C $(BUILD_DIR_RELEASE) distcheck

$(BUILD_DIR_DEBUG): configure
	-mkdir -v $(BUILD_DIR_DEBUG)
	cd $(BUILD_DIR_DEBUG) && ../configure CXXFLAGS='-g -Og'

$(BUILD_DIR_RELEASE): configure
	-mkdir -v $(BUILD_DIR_RELEASE)
	cd $(BUILD_DIR_RELEASE) && ../configure CXXFLAGS='-O3'

clean:
	-rm -rfv $(BUILD_DIR_DEBUG)
	-rm -rfv $(BUILD_DIR_RELEASE)
	-rm -rfv autom4te.cache
	-rm -fv missing install-sh depcomp configure config.h.in aclocal.m4
	-find . -name "Makefile.in" -type f -delete