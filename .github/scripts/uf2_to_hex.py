#!/usr/bin/env python3
"""Convert UF2 firmware file to Intel HEX format for Nordic DFU."""

import struct
import sys
from intelhex import IntelHex


def convert_uf2_to_hex(uf2_file):
    """Convert a UF2 file to Intel HEX format.

    Args:
        uf2_file: Path to the input UF2 file

    Returns:
        Path to the generated HEX file
    """
    print(f"Converting {uf2_file} to HEX...")

    ih = IntelHex()

    with open(uf2_file, 'rb') as f:
        while True:
            block = f.read(512)
            if len(block) < 512:
                break

            # Parse UF2 block header
            magic_start = struct.unpack('<I', block[0:4])[0]
            if magic_start != 0x0A324655:  # UF2 magic number
                continue

            # Extract address and payload
            target_addr = struct.unpack('<I', block[12:16])[0]
            payload_size = struct.unpack('<I', block[16:20])[0]
            payload = block[32:32+payload_size]

            # Add payload to Intel HEX at target address
            for i, byte in enumerate(payload):
                ih[target_addr + i] = byte

    # Write HEX file
    hex_file = uf2_file.replace('.uf2', '.hex')
    ih.write_hex_file(hex_file)
    print(f"✅ Created HEX file: {hex_file}")

    return hex_file


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: uf2_to_hex.py <input.uf2>")
        sys.exit(1)

    convert_uf2_to_hex(sys.argv[1])
