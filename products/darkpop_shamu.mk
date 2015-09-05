# Inherit AOSP device configuration for shamu.
$(call inherit-product, device/moto/shamu/aosp_shamu.mk)

# Inherit common product files.
$(call inherit-product, vendor/darkpop/products/common.mk)

# Override AOSP build properties
PRODUCT_NAME := darkpop_shamu
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus 6
PRODUCT_MANUFACTURER := motorola
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME="hammerhead" BUILD_FINGERPRINT="google/hammerhead/hammerhead:5.1.1/LYZ28J/2128181:user/release-keys" PRIVATE_BUILD_DESC="hammerhead-user 5.1.1 LYZ28J 2128181 release-keys"

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/darkpop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip
