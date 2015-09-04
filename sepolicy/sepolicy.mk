#
# This policy configuration will be used by all products that
# inherit from DARKPOP
#

BOARD_SEPOLICY_DIRS += \
    vendor/darkpop/sepolicy

BOARD_SEPOLICY_UNION += \
service_contexts \
system.te
  

