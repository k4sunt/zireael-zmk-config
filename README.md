# ZMK Firmware for Zireael keyboard

## Default Zireael

### Zireael

Visual representation of the default keymap in keyboard-layout-editor: [KLE](http://www.keyboard-layout-editor.com/#/gists/67a81f6b83c65abcda5e7f32989a1688)

This layout is heavily inspired by [this](https://github.com/aroum/Watchman-layouts)

## nRF52840 USB Dongle Support

This configuration now supports using an nRF52840 USB dongle as a central device for the split keyboard. The dongle acts as the master device, connecting to both keyboard halves via Bluetooth Low Energy, while providing USB connectivity to your computer.

### Dongle Benefits

- **Battery Life**: Both keyboard halves can now be peripherals, potentially extending battery life
- **USB Connectivity**: Always-on USB connection through the dongle
- **Multiple Bluetooth Profiles**: The dongle can manage up to 5 Bluetooth connections
- **Output Switching**: Switch between USB and Bluetooth outputs using the BT layer


## FAQ

- [FAQ](#faq)
  - [How to change the keymap?](#how-to-change-the-keymap)
  - [How to flash the keyboard?](#how-to-flash-the-keyboard)
  - [How to pair halves?](#how-to-pair-halves)
  - [Problems](#problems)
    - [I'm getting File Transfer Error after copying firmware to the keyboard](#im-getting-file-transfer-error-after-copying-firmware-to-the-keyboard)

### How to change the keymap?

1. Fork the repository https://github.com/Mposiblee/zireael-zmk-config
2. Make changes to the [dao.keymap](../config/boards/arm/dao/dao.keymap) file in your repository OR use wonderful https://nickcoutsos.github.io/keymap-editor/
3. Commit changes to your repository
4. Go to `Actions` tab in your repository
5. Wait for the GitHub Action to complete
6. Grab `firmware.zip` file - it contains firmware for both of your halves

### How to flash the keyboard?

1. Obtain `firmware.zip`
2. Unzip `firmware.zip` - you should have `dao_left.uf2`, `dao_right.uf2`, and `dao_dongle.hex` files
3. **Flash the dongle first** (if using dongle setup):
   - The dongle uses Nordic DFU bootloader (not UF2)
   - Generate DFU package from the hex file:
     ```bash
     # Install nrfutil if not already installed
     pip install nrfutil
     
     # Generate DFU package
     ./generate-dfu.sh <path-to-dao_dongle.hex> dao_dongle_dfu.zip
     ```
   - Put the dongle in DFU mode:
     - Press and hold the button on the dongle
     - While holding, plug in the USB cable
     - Release the button
   - Flash using nrfutil:
     ```bash
     nrfutil dfu usb-serial -pkg dao_dongle_dfu.zip -p <serial-port>
     ```
     Or use the nRF Connect Desktop app to flash the DFU package
4. **Flash the keyboard halves**:
   - Turn off the power for selected half (move slider to position `OFF`)
   - Connect selected half to the PC via USB-C cable
   - Press `RESET` button **twice** to enter DFU mode - you should see new USB device in your file manager
   - Copy the corresponding firmware to the root directory of the new USB device
   - Disconnect selected half from the PC
   - Repeat for the other half

### How to pair halves?

#### Without Dongle (Traditional Setup)
1. Turn off the power for both halves (move slider to position `OFF`)
2. Turn on the power for both halves (move slider to position `ON`)
3. Press `RESET` button **once** on both halves **simultaneously**

#### With Dongle Setup
1. Turn off the power for both halves (move slider to position `OFF`)
2. Turn on the power for both halves (move slider to position `ON`)
3. Press `RESET` button **once** on both halves **simultaneously**
4. The dongle will automatically discover and connect to both halves
5. Use the BT layer on the keyboard or dongle to select and manage connections

### Using the Dongle

The nRF52840 dongle provides several benefits:
- **Bluetooth Management**: The dongle can store up to 5 Bluetooth profiles
- **Output Switching**: Use `Fn + Space` (OUT_USB) and `Fn + Backspace` (OUT_BLE) to switch between USB and Bluetooth outputs
- **Connection Status**: The dongle's LEDs indicate connection status and activity

### Problems

#### I'm getting File Transfer Error after copying firmware to the keyboard

It's OK. Proof: https://zmk.dev/docs/troubleshooting#file-transfer-error
