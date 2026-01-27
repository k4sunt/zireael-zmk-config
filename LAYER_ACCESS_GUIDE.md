# Layer Access Guide - Dao Keyboard

## 📊 Layer Overview

```
Layer 0: DEF  → Default layer (Colemak-DH)
Layer 1: LWR  → Lower (Symbols & Numbers)
Layer 2: RSE  → Raise (VSCode shortcuts)
Layer 3: FUN  → Function (F-keys, Media, Caps Word)
Layer 4: BTL  → Bluetooth (BT management, Bootloader, Reset)
```

## 🎹 Thumb Cluster Layout

```
Left Side:                Right Side:
┌─────────┬─────────┬────────────┐   ┌───────────────┬─────┬─────────┐
│ LCTRL   │ LGUI/   │ LWR/       │   │ RSE/          │ TAB │ RSHFT   │
│ (outer) │ ENTER   │ SPACE      │   │ BACKSPACE     │     │ (outer) │
└─────────┴─────────┴────────────┘   └───────────────┴─────┴─────────┘
Position:    39         40           41         42       43      44
```

## 🔑 How to Access Each Layer

### Layer 0: DEF (Default)
**Access:** Always active - your base layer
- Colemak-DH layout
- Sticky modifiers (Alt, Shift, Ctrl)

---

### Layer 1: LWR (Lower - Symbols & Numbers)
**Access:** Hold **SPACE** (thumb cluster, left side)

```
While holding Space:
- Top row: ! @ # $ % ^ & * ( ) \
- Home row: 1 2 3 4 5 6 7 8 9 0
- Bottom row: ~ ` [ { } ] - = ; :
```

**Use for:** Numbers, symbols, brackets

---

### Layer 2: RSE (Raise - VSCode)
**Access:** Hold **BACKSPACE** (thumb cluster, right side)

```
While holding Backspace:
- VSCode shortcuts (Cmd+P, Cmd+Shift+P, etc.)
- Arrow keys (←↓↑→)
- Home/End
- Copy/Paste/Undo/Redo
```

**Use for:** Code navigation, VSCode shortcuts, arrows

---

### Layer 3: FUN (Function) ⚡
**Access:** Hold **SPACE + BACKSPACE** simultaneously (conditional layer)

```
When holding BOTH Space AND Backspace:
- Automatically activates FUN layer
- F1-F13 keys
- Media controls (Play, Prev, Next, Vol+/-)
- Caps Word
- Insert, PrintScreen
```

**How it works:**
1. Press and hold **Space** (LWR activates)
2. While still holding Space, press and hold **Backspace** (RSE activates)
3. **FUN layer automatically appears!** ✨
4. Release either key to exit

**Alternative access:**
- You can also hold RSE first, then add LWR
- Order doesn't matter - both held = FUN active

**Use for:** Function keys, media controls, system functions

---

### Layer 4: BTL (Bluetooth) 🔵
**Access:** Press **LCTRL + RSHFT** together (combo - both outer thumb keys)

```
Press both outer thumb keys simultaneously:

  Left outer thumb (LCTRL position)
         +
  Right outer thumb (RSHFT position)
         ↓
    BTL layer activated!
```

**Layout:**
```
Top row: BOOTLOADER | (empty) | ... | BOOTLOADER
Home row: BT_CLR | BT_SEL 0-4 | ... | BT_SEL 4-0 | BT_CLR
Bottom row: SYS_RESET | (empty) | ... | SYS_RESET
```

**What you can do:**
- **BT_CLR** - Clear all Bluetooth pairings
- **BT_SEL 0-4** - Select Bluetooth profile (0-4)
- **BOOTLOADER** - Enter bootloader mode (for flashing)
- **SYS_RESET** - Reset the keyboard

**Use for:** Switching BT devices, clearing pairings, flashing firmware

---

## 💡 Quick Reference

| Layer | Access Method | Hold/Tap | Type |
|-------|---------------|----------|------|
| **DEF** | Always active | - | Base |
| **LWR** | Hold Space | Hold | Layer-tap |
| **RSE** | Hold Backspace | Hold | Layer-tap |
| **FUN** | Hold Space + Backspace | Hold both | Conditional |
| **BTL** | Both outer thumbs together | Tap together | Combo |

## 🎯 Pro Tips

### Accessing FUN Layer:
1. **Don't press them at exactly the same time** - start with one, then add the other
2. **Space first, then Backspace** - easier for most people
3. **Or Backspace first, then Space** - whichever feels natural
4. Once both are held, FUN is active automatically

### Accessing BTL Layer:
1. **Press both outer thumb keys together** - like a piano chord
2. Works from DEF, LWR, or RSE layers
3. **Timeout: 50ms** - press them close together (not exact same time)
4. Much faster than the old method (mo from LWR layer)

### Layer-Tap Keys:
- **Quick tap** → Key press (Space, Backspace)
- **Hold** → Layer activation (LWR, RSE)
- **Timing:** 200ms - tap faster than this for key, hold longer for layer

## 🔍 Troubleshooting

**"FUN layer not activating"**
- Make sure you're holding **both** Space and Backspace
- Hold one, then add the other - don't release the first
- Try holding them for 300ms+ to be sure

**"BTL combo not working"**
- Press both outer thumb keys within 50ms of each other
- They should be pressed nearly simultaneously
- Try a "rolling" motion - one slightly before the other
- Make sure you're pressing the correct keys (LCTRL and RSHFT positions)

**"Getting Space or Backspace instead of layers"**
- You're tapping too fast - hold the keys longer (200ms+)
- The tapping_term is 200ms - hold past that for layer activation

## 📝 Visual Summary

```
Thumb Cluster Access:
┌─────────────┬──────────────┬─────────────┐   ┌──────────────┬─────┬─────────────┐
│   LCTRL     │   LGUI/      │   LWR/      │   │   RSE/       │ TAB │   RSHFT     │
│  (combo)    │   ENTER      │   SPACE     │   │   BACKSPACE  │     │  (combo)    │
│             │              │   (hold)    │   │   (hold)     │     │             │
└─────────────┴──────────────┴─────────────┘   └──────────────┴─────┴─────────────┘
      │                              │                  │                    │
      │                              │                  │                    │
      └────────── Both together ─────┴──── Both held ───┴────────────────────┘
                      ↓                         ↓
                  BTL Layer                FUN Layer
                  (combo)                  (conditional)
```

## 🎮 Practice Exercises

1. **Access FUN layer:**
   - Hold Space (LWR activates)
   - Add Backspace (RSE activates)
   - FUN should be active → Try pressing keys to see F-keys

2. **Access BTL layer:**
   - Press both outer thumb keys together
   - You should see Bluetooth options
   - Release to return to base layer

3. **Quick layer switching:**
   - Hold Space → Type numbers
   - Release Space, hold Backspace → Use arrows
   - Hold both → Press F5 to refresh
