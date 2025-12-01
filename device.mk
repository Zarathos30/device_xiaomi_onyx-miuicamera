#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Camera
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/onyx-miuicamera/onyx-miuicamera-vendor.mk)

# Miuicamera
PRODUCT_PACKAGES += \
    MiuiCameraOverlayIcon

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/default-permissions-miuicamera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/default-permissions-miuicamera.xml \
    $(LOCAL_PATH)/configs/permissions/miuicamera-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/miuicamera-hiddenapi-package-whitelist.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-miuicamera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-miuicamera.xml

# Xiaomi Scanner
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/default-permissions-scanner.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/default-permissions-scanner.xml \
    $(LOCAL_PATH)/configs/permissions/scanner-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/scanner-hiddenapi-package-whitelist.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-scanner.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-scanner.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
