# Written for UBER toolchains
# Find host os

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

UNAME := $(shell uname -s)

ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

# Only use these compilers on linux host.
ifeq (linux,$(HOST_OS))

# Add extra libs for the compilers to use
# Filter by TARGET_ARCH since we're pointing to ARCH specific compilers.
# To use this on new devices define TARGET_ARCH in device makefile.
ifeq (arm,$(TARGET_ARCH))
export LD_LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.8/arch-arm/usr/lib
export LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.8/arch-arm/usr/lib

# Path to toolchain
UBER_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.8
UBER_AND := $(shell $(UBER_AND_PATH)/bin/arm-linux-androideabi-gcc --version)

# Find strings in version info
ifneq ($(filter (UBERTC%),$(UBER_AND)),)
UBER_AND_NAME := $(filter (UBERTC%),$(UBER_AND))
UBER_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(UBER_AND))
UBER_AND_STATUS := $(filter (release) (prerelease) (experimental),$(UBER_AND))
UBER_AND_VERSION := $(UBER_AND_NAME)-$(UBER_AND_DATE)-$(UBER_AND_STATUS)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.uber.android=$(UBER_AND_VERSION)
endif

UBER_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-4.9
UBER_KERNEL := $(shell $(UBER_KERNEL_PATH)/bin/arm-eabi-gcc --version)

ifneq ($(filter (UBERTC%),$(UBER_KERNEL)),)
UBER_KERNEL_NAME := $(filter (UBERTC%),$(UBER_KERNEL))
UBER_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(UBER_KERNEL))
UBER_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(UBER_KERNEL))
UBER_KERNEL_VERSION := $(UBER_KERNEL_NAME)-$(UBER_KERNEL_DATE)-$(UBER_KERNEL_STATUS)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.uber.kernel=$(UBER_KERNEL_VERSION)
endif

ifeq (true,$(GRAPHITE_OPTS))
OPT1 := (graphite)
endif
endif

ifeq (arm64,$(TARGET_ARCH))
export LD_LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9/arch-arm64/usr/lib
export LIBRARY_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9/arch-arm64/usr/lib

# Path to toolchain
UBER_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9
UBER_AND := $(shell $(UBER_AND_PATH)/bin/aarch64-linux-android-gcc --version)

# Find strings in version info
ifneq ($(filter (UBERTC%),$(UBER_AND)),)
UBER_AND_NAME := $(filter (UBERTC%),$(UBER_AND))
UBER_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(UBER_AND))
UBER_AND_STATUS := $(filter (release) (prerelease) (experimental),$(UBER_AND))
UBER_AND_VERSION := $(UBER_AND_NAME)-$(UBER_AND_DATE)-$(UBER_AND_STATUS)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.uber.android=$(UBER_AND_VERSION)
endif

ifeq (true,$(GRAPHITE_OPTS))
OPT1 := (graphite)
endif
endif
endif

ifeq (true,$(STRICT_ALIASING))
OPT2 := (strict)
endif

ifeq (true,$(USE_O3_OPTIMIZATIONS))
OPT3 := (O3)
endif

ifeq (true,$(KRAIT_TUNINGS))
OPT4 := (krait)
endif

ifeq (true,$(ENABLE_GCCONLY))
OPT5 := (gcconly)
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)$(OPT5)
ifneq (,$(GCC_OPTIMIZATION_LEVELS))
PRODUCT_PROPERTY_OVERRIDES += \
    ro.uber.flags=$(GCC_OPTIMIZATION_LEVELS)
endif

