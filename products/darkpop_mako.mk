# Inherit AOSP device configuration for mako.
$(call inherit-product, device/lge/mako/aosp_mako.mk)

# Inherit common product files.
$(call inherit-product, vendor/darkpop/config/common.mk)

# Override AOSP build properties
PRODUCT_NAME := darkpop_mako
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus 4
PRODUCT_MANUFACTURER := LGE
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME="mako" BUILD_FINGERPRINT="google/mako/mako:5.1.1/LYZ28J/2128181:user/release-keys" PRIVATE_BUILD_DESC="mako-user 5.1.1 LYZ28J 2128181 release-keys"

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/darkpop/prebuilt/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip
