###############################################
# Sample makefile for building a C++ project  #
###############################################

PROJECT_ROOT := ../..

# Assuming your project source files are in the current directory.
SOURCES = $(shell find . -name '*.cpp')

OBJECTS = $(SOURCES:.cpp=.o)

# Assign your project's output binary name
OUT = app

# Root directory of the build environment.
# Hint: Where your sysroot is.
# Another hint: Where you cloned this repo.
DEVENV_DIR = /home/<user>/RPi-Cross-Build-Environment

SYSROOT_DIR = $(DEVENV_DIR)/sysroot
SYSROOT = --sysroot=$(SYSROOT_DIR)
MISC_DIR = $(DEVENV_DIR)/misc

# Toolchain prefix. You can assign whatever you're using.
# Hardcoded one for now.
TOOLCHAIN_PREFIX = arm-linux-gnueabihf-

CXX = $(TOOLCHAIN_PREFIX)g++
AR = $(TOOLCHAIN_PREFIX)ar

# Library linkages
LIB_DIRS = -L$(MISC_DIR)/lib -L$(PROJECT_ROOT)/build/lib \
	-L$(SYSROOT_DIR)/usr/lib/arm-linux-gnueabihf \
	-L$(SYSROOT_DIR)/opt/vc/lib -L$(SYSROOT_DIR)/usr/local/lib

LIBS = $(LIB_DIRS)	\
	-Wl,--start-group \
	-lpthread -lcrypto -lssl -ldl	\
	-lstdc++ \
	-Wl,--end-group

LFLAGS = \
	--sysroot=$(SYSROOT_DIR) \
	-Wl,-rpath-link,$(SYSROOT_DIR)/opt/vc/lib \
	-Wl,-rpath-link,$(SYSROOT_DIR)/usr/lib/arm-linux-gnueabihf \
	-Wl,-rpath-link,$(SYSROOT_DIR)/lib/arm-linux-gnueabihf

# Compiler flags
CXXFLAGS = -pipe -marm -mfpu=vfp -mtune=arm1176jzf-s -march=armv6zk \
	-mabi=aapcs-linux -mfloat-abi=hard -std=gnu++11 -Wall -fPIC \
	-fpermissive	\
	$(SYSROOT) $(EXTRA_CXXFLAGS)

# Custom macros
DEFINES = -DSTD_CXX=11

# Custom macro definitions
# XXX... Unused as for now.
CONFIGS = 

# Command line arg parse
ifeq ($(debug), y)
	CXXFLAGS += -g -O0 -ggdb
	DEFINES += -DDEBUG_ON
	OUT := $(OUT)-dbg
endif

# Directories for required header files
INCLUDES = -I../../include -I$(MISC_DIR)/include -I$(SYSROOT_DIR)/usr/include/arm-linux-gnueabihf

CPPFLAGS = $(DEFINES) $(INCLUDES)

# Generate intermediate object files
%.o: %.cpp
	@echo "\n-----------------------------------------"
	@echo $<
	@echo "-------------------------------------------"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $< -c -o $@ $(LIBS)

$(OUT): $(OBJECTS)
	@echo "\n-----------------------------------------"
	@echo "              Linking                   "
	@echo "-------------------------------------------"
	$(CXX) $(LFLAGS) $(CXXFLAGS) $^ -o $@ $(LIBS)

.PHONY: build
build: $(OUT)

.PHONY: clean
clean:
	-rm -rf $(OBJECTS) $(OUT) *.o

DEPLOY_FILES = $(OUT)
TARGET_DEPLOY_DIR = /home/$(TARGET_USR)/<your-app-build-dir>

.PHONY: deploy
deploy:
	scp $(DEPLOY_FILES) $(TARGET_USR)@$(TARGET_IP):$(TARGET_DEPLOY_DIR)
