# Copyright (C) 2014 OptiPop Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Check for target product

ifeq (optipop_d801,$(TARGET_PRODUCT))

# Define TARGET_ARCH for what toolchain libs to use.
TARGET_ARCH := arm

# Include OptiPop common configuration
include vendor/optipop/config/common.mk

# Inherit AOSP device configuration
$(call inherit-product, device/lge/d801/full_d801.mk)

# Override AOSP build properties
PRODUCT_NAME := optipop_d801
PRODUCT_BRAND := LGE
PRODUCT_MODEL := LG-D801
PRODUCT_MANUFACTURER := LGE
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME="d801" BUILD_FINGERPRINT="lge/g2_tmo_us/g2:4.4.2/KOT49I.D80120g/D80120g.1414567414:user/release-keys"
PRIVATE_BUILD_DESC="g2_tmo_us-user 4.4.2 KOT49I.D80120g D80120g.1414567414 release-keys"

# Kernel inline build
TARGET_KERNEL_SOURCE := kernel/lge/msm8974
TARGET_KERNEL_CONFIG := optipop_d801_defconfig

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/optipop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip

endif
