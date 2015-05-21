# Copyright (C) 2015 OptiPop Project
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

# Inherit AOSP device configuration for grouper
$(call inherit-product, device/asus/grouper/full_grouper.mk)

# Include OptiPop common configuration
include vendor/optipop/config/common.mk

# Setup device specific product configuration
PRODUCT_NAME := optipop_grouper
PRODUCT_BRAND := google
PRODUCT_DEVICE := grouper
PRODUCT_MODEL := Nexus 7
PRODUCT_MANUFACTURER := asus

# Build prop fingerprint overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=nakasi \
    BUILD_FINGERPRINT=google/nakasi/grouper:5.1.1/LMY48B/1863243:user/release-keys \
    PRIVATE_BUILD_DESC="nakasi-user 5.1.1 LMY48B 1863243 release-keys"

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/optipop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip
