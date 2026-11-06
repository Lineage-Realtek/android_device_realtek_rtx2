#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Not set in time to check, so set before everything else
PRODUCT_IS_ATV := true

# Enable bring-up ADB before inheriting the common Lineage configuration.
WITH_ADB_INSECURE := true

# Inherit some common AOSP stuff
$(call inherit-product, device/google/atv/products/atv_base.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_tv.mk)

# Inherit device configuration
$(call inherit-product, $(LOCAL_PATH)/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_BRAND := Realtek
PRODUCT_DEVICE := rtx2
PRODUCT_MANUFACTURER := Realtek
PRODUCT_MODEL := RT-X2
PRODUCT_NAME := lineage_rtx2

PRODUCT_GMS_CLIENTID_BASE := android-droid-tv

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="RTD1325_AOSP_BOX-userdebug 14 UD2A.231203.054 260625134925 test-keys" \
    BuildFingerprint=Google/RTD1325_AOSP_BOX/ross:14/UD2A.231203.054/260625134925:userdebug/test-keys \
    SystemName=RTD1325_AOSP_BOX
