#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realtek/rtx2
KERNEL_PATH := device/realtek/rtx2-kernel

## Bootloader
TARGET_BOOTLOADER_BOARD_NAME := LivingVampire

## Display
TARGET_SCREEN_DENSITY := 320

## Kernel (prebuilt, from the stock OTA, see rtd1325-common/tools/import-prebuilt-kernel.sh)
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image.gz
TARGET_PREBUILT_KERNEL_HEADERS := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

## Kernel modules
# First stage: clocks, pinctrl, TEE, heaps and the eMMC host
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/vendor_boot/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor_boot.modules.load))

# Recovery cannot use the normal-boot init.insmod.sh service in /vendor.
# Bundle the display/RPC, remote and USB drivers in vendor_boot as well,
# and load them only in recovery, after the usual first stage modules.
RTX2_RECOVERY_KERNEL_MODULES := \
    i2c-rtk.ko \
    pwm-rtk.ko \
    rpmsg_rtk.ko \
    rtk_rpc_mem.ko \
    rtk_fwdbg.ko \
    rtk_krpc_agent.ko \
    rtk_urpc_service.ko \
    rtk_avcpulog.ko \
    rtk_refclk.ko \
    rtk_drm.ko \
    rtk_pm_suspend.ko \
    rc-realtek-dhc.ko \
    rc-realtek-sri.ko \
    rtk-ir.ko \
    rtk-usb-manager.ko \
    phy-rtk-usb3.ko \
    phy-rtk-usb2.ko \
    dwc3-rtk-debugfs.ko \
    dwc3-rtk.ko \
    extcon-rtk-type-c.ko

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(addprefix $(KERNEL_PATH)/modules/vendor_dlkm/,$(RTX2_RECOVERY_KERNEL_MODULES))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD) $(RTX2_RECOVERY_KERNEL_MODULES)

# Second stage: loaded by init.insmod.sh from init.insmod.cfg, not by init
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/vendor_dlkm/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor_dlkm.modules.load))

# GKI modules, some of them signed: install them as they are
BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/modules/system_dlkm/*.ko)

## Partitions
# Stock super, 1920 MiB
BOARD_SUPER_PARTITION_SIZE := 2013265920

## Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

## Include the common tree BoardConfig makefile
include device/realtek/rtd1325-common/BoardConfigCommon.mk

## Include the proprietary BoardConfig makefile
include vendor/realtek/rtx2/BoardConfigVendor.mk
