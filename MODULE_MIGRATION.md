# ZMK Module Migration - Dao Keyboard

## Why The Firmware Showed "SETTINGS ERASE"

The firmware was building successfully but **not running** because the board definitions were in the wrong location for Zephyr 4.x / ZMK.

### Root Cause

**Problem:** Board definitions were in `config/boards/` which is **deprecated** in ZMK with Zephyr 4.x.

**Effect:** The build system ignored or couldn't properly find the board definitions, so it built generic/fallback firmware that only shows "SETTINGS ERASE" on Bluetooth.

**Build Warning:**
```
CMake Deprecation Warning: The `config/boards` folder is deprecated.
Please use a module instead.
```

---

## The Solution: ZMK Module Structure

### What Changed

**Before (BROKEN):**
```
zireael-zmk-config/
├── config/
│   └── boards/dao/           ❌ Deprecated location
│       ├── dao_left/
│       └── dao_right/
└── build.yaml
```

**After (CORRECT):**
```
zireael-zmk-config/
├── modules/dao/              ✅ ZMK Module
│   ├── zephyr/
│   │   └── module.yml        ✅ Module definition
│   └── boards/dao/           ✅ Board definitions
│       ├── dao.dtsi
│       ├── dao_left/
│       └── dao_right/
├── config/
│   ├── west.yml              ✅ References module
│   ├── dao.keymap
│   └── dao.conf
└── build.yaml                ✅ No BOARD_ROOT needed
```

---

## Migration Steps Applied

### Step 1: Create Module Structure (Commit ac504e0)

Created proper ZMK module directory:
```bash
modules/dao/
├── zephyr/module.yml    # Module definition with board_root
└── boards/dao/          # All board files moved here
    ├── dao.dtsi
    ├── dao_left/
    │   ├── board.yml
    │   ├── dao_left_nrf52840.dts
    │   ├── dao_left_nrf52840.defconfig
    │   ├── Kconfig.dao_left
    │   ├── Kconfig.defconfig
    │   └── board.cmake
    └── dao_right/
        └── (same structure as dao_left)
```

**modules/dao/zephyr/module.yml:**
```yaml
name: dao
build:
  settings:
    board_root: .
```

This tells Zephyr's build system where to find board definitions within the module.

### Step 2: Update build.yaml (Commit ac504e0)

**Before:**
```yaml
include:
  - board: dao_left
    cmake-args: -DBOARD_ROOT=config
  - board: dao_right
    cmake-args: -DBOARD_ROOT=config
```

**After:**
```yaml
include:
  - board: dao_left
  - board: dao_right
```

The module's `module.yml` now handles the board_root setting, so we don't need to specify it in build.yaml.

### Step 3: Remove Deprecated Directory (Commit 89ef643)

Deleted `config/boards/` completely to avoid conflicts:
```bash
rm -rf config/boards/
```

### Step 4: Register Module in west.yml (Commit 73a1d17)

**Before:**
```yaml
manifest:
  projects:
    - name: zmk
      remote: zmkfirmware
      revision: main
      import: app/west.yml
  self:
    path: config
```

**After:**
```yaml
manifest:
  projects:
    - name: zmk
      remote: zmkfirmware
      revision: main
      import: app/west.yml
  self:
    path: config
    west-commands: scripts/west-commands.yml
    import:
      - ../modules/dao/zephyr/module.yml  # ← Import in-repo module
```

This is **critical** - West needs to import the in-repo module to load it during the build. Note: In-repo modules use `self.import`, not `projects` (which is for external repos with URLs).

---

## How ZMK Module Discovery Works

1. **West reads `config/west.yml`** and processes the `self.import` directive
2. **West imports `modules/dao/zephyr/module.yml`** as part of the workspace
3. **Module.yml specifies `board_root: .`** (relative to modules/dao/)
4. **Zephyr finds boards** in `modules/dao/boards/dao/dao_left/` and `dao_right/`
5. **Build system recognizes** `dao_left` and `dao_right` as valid boards
6. **Firmware builds** with actual board definitions, not fallback code

---

## Why This is Required for Zephyr 4.x

Zephyr 4.x (starting with 3.5+) uses **Hardware Model v2** which requires:
- Board definitions in modules (not directly in config/)
- Proper module.yml with build settings
- West manifest references to modules
- board.yml files with SoC metadata

The old `config/boards/` approach worked in Zephyr 3.2 and earlier but is deprecated and ignored in Zephyr 4.x.

---

## Verification

After these changes, the build should:

1. ✅ Find the `dao_left` and `dao_right` boards
2. ✅ Load board definitions from the module
3. ✅ Build firmware with actual keyboard functionality
4. ✅ No longer show "SETTINGS ERASE" after flashing

**Expected Build Output:**
```
-- Board: dao_left, qualifiers: nrf52840
-- Found BOARD.dts: <path>/modules/dao/boards/dao/dao_left/dao_left_nrf52840.dts
-- Using keymap file: <path>/config/dao_left.keymap
```

**After Flashing:**
- Left keyboard: Shows "Dao" on Bluetooth ✅
- Right keyboard: Shows "Dao Right" on Bluetooth ✅
- Full keyboard functionality with all layers ✅

---

## Files Modified

### New Files:
- `modules/dao/zephyr/module.yml` - Module definition
- `modules/dao/boards/dao/` - All board files (moved from config/)

### Modified Files:
- `config/west.yml` - Added dao module reference
- `build.yaml` - Removed BOARD_ROOT cmake args

### Deleted Files:
- `config/boards/` - Entire deprecated directory removed

---

## Commits Applied

```
73a1d17 Register dao module in west manifest
89ef643 Remove deprecated config/boards directory
ac504e0 CRITICAL: Move board definitions to ZMK module structure
```

---

## Additional Context

This migration also preserves all the HWMv2 fixes we made earlier:
- ✅ Proper devicetree structure (DTS headers in correct files)
- ✅ Complete Kconfig configuration (SOC, ARM, CPU)
- ✅ Fixed combo key positions (BTL combo)
- ✅ Split keyboard BLE configuration
- ✅ Enhanced keymap with combos and improvements

The module structure is the final piece needed to make everything work together properly in Zephyr 4.x.

---

## Testing

Push these changes and test the new build:

```bash
git push
```

After GitHub Actions completes:
1. Download `dao_left.uf2` and `dao_right.uf2`
2. Flash to both keyboard halves
3. Verify BLE names show correctly (not "SETTINGS ERASE")
4. Test all layers and keyboard functionality

**This should finally fix the firmware runtime issue!** 🎯
