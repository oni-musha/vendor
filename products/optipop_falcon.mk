# Inherit AOSP device configuration for falcon
$(call inherit-product, device/motorola/falcon/full_falcon.mk)

# Define TARGET_ARCH for what toolchain libs to use.
TARGET_ARCH := arm

# Include OptiPop common configuration
include vendor/optipop/config/common.mk

# Inherit common product files
$(call inherit-product, vendor/optipop/config/common.mk)

# Setup device specific product configuration
PRODUCT_NAME := optipop_falcon
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := falcon 
PRODUCT_MODEL := moto g
PRODUCT_MANUFACTURER := MOTOROLA


# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/optipop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip
