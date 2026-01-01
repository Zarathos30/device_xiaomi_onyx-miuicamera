#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

MIUICAMERA_PATH := device/xiaomi/onyx-miuicamera

# Inherit from the proprietary version
include vendor/xiaomi/onyx-miuicamera/BoardConfigVendor.mk

# MiuiCamera
CAMERA_PACKAGE_NAME := com.android.camera

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(MIUICAMERA_PATH)/sepolicy/vendor

BUILD_BROKEN_DUP_RULES := true

TARGET_CAMERA_USES_NEWER_HIDL_OVERRIDE_FORMAT = true
TARGET_INCLUDES_MIUI_CAMERA := true
TARGET_USES_MIUI_CAMERA := true
