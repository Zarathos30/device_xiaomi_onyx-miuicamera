#!/bin/bash
#
# Patch MiuiCamera APK for AOSP/LineageOS compatibility
# Decompiles the APK, applies smali patches, and rebuilds
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PATCHES_DIR="$SCRIPT_DIR/miui-camera-patches"
TOP_DIR="$(pwd)"
VENDOR_APK="$TOP_DIR/vendor/xiaomi/onyx-miuicamera/proprietary/system/priv-app/MiuiCamera/MiuiCamera.apk"
WORK_DIR="/tmp/miuicamera-patch-$$"

if [ ! -f "$VENDOR_APK" ]; then
    echo "ERROR: $VENDOR_APK not found. Extract blobs first."
    exit 1
fi

if ! command -v apktool &> /dev/null; then
    echo "ERROR: apktool not found in PATH"
    exit 1
fi

echo "==> Decompiling MiuiCamera.apk..."
mkdir -p "$WORK_DIR"
apktool d "$VENDOR_APK" -o "$WORK_DIR/MiuiCamera" -f

echo "==> Initializing git for patching..."
cd "$WORK_DIR/MiuiCamera"
git init -q
git add -A
git commit -q -m "initial"

echo "==> Applying patches..."
FAILED=0
for patch in "$PATCHES_DIR"/*.patch; do
    PATCH_NAME="$(basename "$patch")"
    if git apply --check --ignore-whitespace "$patch" 2>/dev/null; then
        git apply --ignore-whitespace "$patch"
        echo "  [OK] $PATCH_NAME"
    elif git apply --check "$patch" 2>/dev/null; then
        git apply "$patch"
        echo "  [OK] $PATCH_NAME"
    else
        echo "  [FAIL] $PATCH_NAME"
        FAILED=$((FAILED + 1))
    fi
done

if [ "$FAILED" -gt 0 ]; then
    echo "WARNING: $FAILED patch(es) failed to apply."
fi

echo "==> Rebuilding MiuiCamera.apk..."
cd "$WORK_DIR"
apktool b MiuiCamera -o MiuiCamera-patched.apk

echo "==> Replacing vendor APK..."
cp "$VENDOR_APK" "${VENDOR_APK}.bak"
cp "$WORK_DIR/MiuiCamera-patched.apk" "$VENDOR_APK"

echo "==> Cleaning up..."
rm -rf "$WORK_DIR"

echo "==> Done! Patched APK installed."
echo "    Backup saved as ${VENDOR_APK}.bak"
