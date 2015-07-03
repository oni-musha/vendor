# Written for UBER toolchains
# Find host os

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

UNAME := $(shell uname -s)

ifeq (Linux,$(UNAME))
  HOST_OS := linux
endif

ifeq (linux,$(HOST_OS))
ifeq (arm,$(TARGET_ARCH))
# Path to toolchain
AND_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_GCC_VERSION)
AND_TC_VERSION := $(shell $(AND_TC_PATH)/bin/arm-linux-androideabi-gcc --version 2>&1)
AND_TC_VERSION_NUMBER := $(shell $(AND_TC_PATH)/bin/arm-linux-androideabi-gcc -dumpversion 2>&1)

# Find strings in version info
ifneq ($(filter (UBERTC%),$(AND_TC_VERSION)),)
AND_TC_NAME := UBERTC
else
AND_TC_NAME := GCC
endif

AND_TC_DATE := $(filter 20150% 20151% ,$(AND_TC_VERSION))
ifeq ($(AND_TC_DATE),)
	AND_TC_DATE := $(filter 2014% ,$(AND_TC_VERSION))
endif

ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.android=($(AND_TC_NAME)-$(AND_TC_VERSION_NUMBER))-$(AND_TC_DATE)

ifneq ($(TARGET_GCC_VERSION_ARM),)
KERNEL_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_GCC_VERSION_ARM)
else
KERNEL_TC_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_GCC_VERSION)
endif

KERNEL_TC_VERSION := $(shell $(KERNEL_TC_PATH)/bin/arm-eabi-gcc --version 2>&1)
KERNEL_TC_VERSION_NUMBER := $(shell $(KERNEL_TC_PATH)/bin/arm-eabi-gcc -dumpversion 2>&1)

# Find strings in version info
ifneq ($(filter (UBERTC%),$(KERNEL_TC_VERSION)),)
KERNEL_TC_NAME := UBERTC
else
KERNEL_TC_NAME := GCC
endif

KERNEL_TC_DATE := $(filter 20150% 20151% ,$(KERNEL_TC_VERSION))

ifeq ($(KERNEL_TC_DATE),)
	KERNEL_TC_DATE := $(filter 2014% ,$(KERNEL_TC_VERSION))
endif

ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.kernel=($(KERNEL_TC_NAME)-$(KERNEL_TC_VERSION_NUMBER))-$(KERNEL_TC_DATE)

endif

ifeq (arm64,$(TARGET_ARCH))
# Path to toolchain
UBER_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-4.9
UBER_AND := $(shell $(UBER_AND_PATH)/bin/aarch64-linux-android-gcc --version)

# Find strings in version info
ifneq ($(filter (UBERTC%),$(UBER_AND)),)
UBER_AND_NAME := $(filter (UBERTC%),$(UBER_AND))
UBER_AND_DATE := $(filter 20150% 20151%,$(UBER_AND))
UBER_AND_VERSION := $(UBER_AND_NAME)-$(UBER_AND_DATE)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.android=$(UBER_AND_VERSION)
endif
endif

ifeq (true,$(USE_O3_OPTIMIZATIONS))
OPT1 := (O3)
endif

ifeq (true,$(STRICT_ALIASING))
OPT2 := (strict)
endif

ifeq (true,$(GRAPHITE_OPTS))
OPT3 := (graphite)
endif

ifeq (true,$(KRAIT_TUNINGS))
OPT4 := ($(TARGET_CPU_VARIANT))
endif

ifeq (true,$(ENABLE_GCCONLY))
OPT5 := (gcconly)
endif

ifeq (true,$(FLOOP_NEST_OPTIMIZE))
OPT6 := (floop_nest_optimize)
endif

ifeq (true,$(TARGET_USE_PIPE))
OPT7 := (pipe)
endif

ifeq (true,$(USE_HOST_4_8))
OPT8 := (host_4_8)
endif

ifeq (true,$(FFAST_MATH))
OPT9 := (fast_math)
endif

GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT3)$(OPT4)$(OPT5)$(OPT6)$(OPT7)$(OPT8)$(OPT9)
ifneq (,$(GCC_OPTIMIZATION_LEVELS))
ADDITIONAL_BUILD_PROPERTIES += \
    ro.uber.flags=$(GCC_OPTIMIZATION_LEVELS)
endif
endif
