#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

## Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

## Inherit from the common tree product makefile
$(call inherit-product, device/realtek/rtd1325-common/rtd1325.mk)

## Inherit from the proprietary files makefile
$(call inherit-product, vendor/realtek/rtx2/rtx2-vendor.mk)
