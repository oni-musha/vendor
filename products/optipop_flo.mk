# Inherit AOSP device configuration for flo
$(call inherit-product, device/asus/flo/full_flo.mk)

# Define TARGET_ARCH for what toolchain libs to use.
TARGET_ARCH := arm

# Include OptiPop common configuration
include vendor/optipop/config/common.mk

# Inherit common product files
$(call inherit-product, vendor/optipop/config/common.mk)

# Setup device specific product configuration
PRODUCT_NAME := optipop_flo
PRODUCT_BRAND := google
PRODUCT_DEVICE := flo
PRODUCT_MODEL := Nexus 7
PRODUCT_MANUFACTURER := ASUS

# Build prop fingerprint overrides
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME="razor" BUILD_FINGERPRINT="google/razor/flo:5.0/LRX21M/1551133:user/release-keys" PRIVATE_BUILD_DESC="razor-user 5.0 LRX21M 1551133 release-keys"

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/optipop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip