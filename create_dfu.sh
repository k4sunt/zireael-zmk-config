#!/bin/bash
# Script to create Nordic DFU package for dao_dongle
# Usage: ./create_dfu.sh path/to/dao_dongle.hex

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <path-to-dao_dongle.hex>"
  echo "Example: $0 firmware/dao_dongle.hex"
  exit 1
fi

HEX_FILE="$1"

if [ ! -f "$HEX_FILE" ]; then
  echo "Error: File not found: $HEX_FILE"
  exit 1
fi

OUTPUT_FILE="${HEX_FILE%.hex}-zmk_dfu.zip"

echo "Creating Nordic DFU package..."
echo "Input:  $HEX_FILE"
echo "Output: $OUTPUT_FILE"

nrfutil pkg generate \
  --hw-version 52 \
  --sd-req 0x00,0xB6 \
  --application-version 1 \
  --application "$HEX_FILE" \
  "$OUTPUT_FILE"

echo ""
echo "✅ DFU package created successfully: $OUTPUT_FILE"
echo ""
echo "To flash:"
echo "  nrfutil dfu usb-serial -pkg $OUTPUT_FILE -p /dev/tty.usbmodemXXXXXX"
