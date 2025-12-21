#!/bin/bash
# Script to generate DFU zip package for nRF52840 dongle using nrfutil
# Usage: ./generate-dfu.sh <path-to-hex-file> [output-name]

set -e

HEX_FILE="${1}"
OUTPUT_NAME="${2:-dao_dongle_dfu.zip}"

if [ -z "$HEX_FILE" ]; then
    echo "Usage: $0 <path-to-hex-file> [output-name] [key-file]"
    echo "Example: $0 build/zephyr/zmk.hex dao_dongle_dfu.zip"
    echo "Example (signed): $0 build/zephyr/zmk.hex dao_dongle_dfu.zip private_key.pem"
    echo ""
    echo "Note: If no key file is provided, an unsigned package will be created (suitable for development)"
    exit 1
fi

if [ ! -f "$HEX_FILE" ]; then
    echo "Error: Hex file not found: $HEX_FILE"
    exit 1
fi

# Check if nrfutil is installed
if ! command -v nrfutil &> /dev/null; then
    echo "Error: nrfutil is not installed."
    echo "Install it with: pip install nrfutil"
    exit 1
fi

echo "Generating DFU package from $HEX_FILE..."

# Check for optional key file
KEY_FILE="${3:-/dev/null}"
if [ "$KEY_FILE" != "/dev/null" ] && [ ! -f "$KEY_FILE" ]; then
    echo "Warning: Key file not found: $KEY_FILE"
    echo "Using unsigned package (suitable for development)"
    KEY_FILE="/dev/null"
fi

# Generate DFU package
# For nRF52840 with stock Nordic bootloader:
# - hw-version: 52 (for nRF52840)
# - sd-req: 0x00 (no SoftDevice required for ZMK)
# - application-version: 1 (can be customized)
# - key-file: Use /dev/null for unsigned (development) or provide key file for signed (production)
nrfutil pkg generate \
    --application "$HEX_FILE" \
    --application-version 1 \
    --hw-version 52 \
    --sd-req 0x00 \
    --key-file "$KEY_FILE" \
    "$OUTPUT_NAME"

echo "DFU package generated: $OUTPUT_NAME"
echo ""
echo "To flash the dongle:"
echo "  1. Put the dongle in DFU mode (press the button while plugging in USB)"
echo "  2. Run: nrfutil dfu usb-serial -pkg $OUTPUT_NAME -p <port>"
echo "     Or use nRF Connect Desktop app to flash the package"

