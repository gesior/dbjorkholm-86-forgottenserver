# Lifesteal Attribute Implementation

## Overview
This document describes the implementation of the "lifesteal" attribute for items in The Forgotten Server (TFS) 8.6.

## Features Implemented

### 1. Lifesteal Attribute Definition
- Added `lifesteal` field to the `Abilities` struct in `src/items.h`
- The lifesteal value represents a percentage (0-100) of damage dealt that is converted to health

### 2. XML Parsing
- Added parsing support in `src/items.cpp` to load the "lifesteal" attribute from `items.xml`
- Syntax: `<attribute key="lifesteal" value="5"/>` (for 5% lifesteal)

### 3. Item Description Display
- Modified `src/item.cpp` to display lifesteal value when players examine items
- Format: "lifesteal +X%" is displayed in the item description
- Follows the same formatting style as other item attributes (speed, protection, etc.)

### 4. Combat Healing System
- Implemented lifesteal healing in `src/game.cpp` within the `combatChangeHealth` function
- When a player deals damage:
  1. Calculates total lifesteal percentage from ALL equipped items (stacks additively)
  2. Computes heal amount: `healAmount = (damageDealt * totalLifesteal) / 100`
  3. Heals the player using `gainHealth()` method
  4. Sends a message to the player showing actual health gained

### 5. Status Message
- Displays healing message using `MESSAGE_STATUS_DEFAULT` message type
- Format: "You gained X hitpoint(s) from lifesteal."
- Only shown when actual healing occurs (player not at full health)
- Shows the real amount healed, not the calculated amount

## Files Modified

1. **src/items.h**
   - Added `uint32_t lifesteal;` member to `Abilities` struct
   - Initialized to 0 in constructor

2. **src/items.cpp**
   - Added XML parsing for "lifesteal" attribute in `parseItemNode()` function
   - Located after "manaticks" parsing, before "manashield"

3. **src/item.cpp**
   - Added lifesteal display in `getDescription()` function
   - Located after speed display, before closing parenthesis

4. **src/game.cpp**
   - Added lifesteal healing logic in `combatChangeHealth()` function
   - Located immediately after `target->drainHealth()` call
   - Iterates through equipment slots 1-10 to sum lifesteal values
   - Calculates and applies healing, then sends feedback message

## Usage Examples

### Adding Lifesteal to Items (items.xml)

```xml
<!-- Sword with 5% lifesteal -->
<item id="2400" name="vampiric sword">
    <attribute key="weight" value="4000"/>
    <attribute key="attack" value="35"/>
    <attribute key="defense" value="20"/>
    <attribute key="weapontype" value="sword"/>
    <attribute key="slottype" value="hand"/>
    <attribute key="lifesteal" value="5"/>
</item>

<!-- Ring with 3% lifesteal -->
<item id="2213" name="ring of vampirism">
    <attribute key="weight" value="100"/>
    <attribute key="slottype" value="ring"/>
    <attribute key="lifesteal" value="3"/>
</item>

<!-- Armor with 2% lifesteal -->
<item id="2463" name="vampiric armor">
    <attribute key="weight" value="12000"/>
    <attribute key="armor" value="15"/>
    <attribute key="slottype" value="body"/>
    <attribute key="lifesteal" value="2"/>
</item>
```

## How It Works

### Equipment Slots Checked
The implementation checks the following equipment slots for lifesteal:
- Slot 1: Head
- Slot 2: Necklace
- Slot 3: Backpack
- Slot 4: Armor/Body
- Slot 5: Right Hand
- Slot 6: Left Hand
- Slot 7: Legs
- Slot 8: Feet
- Slot 9: Ring
- Slot 10: Ammo

### Lifesteal Calculation
1. **Total Lifesteal**: Sum of lifesteal values from all equipped items
   - Example: 5% (weapon) + 3% (ring) + 2% (armor) = 10% total

2. **Heal Amount**: `(Damage Dealt × Total Lifesteal) / 100`
   - Example: Deal 100 damage with 10% lifesteal = 10 HP healed

3. **Actual Healing**: Capped by player's missing health
   - If player is at 90/100 HP and would heal for 15, only 10 is applied
   - Message shows only the actual amount healed (10, not 15)

### Message Display
- **Condition**: Only when `actualHealed > 0`
- **Format**: "You gained X hitpoint(s) from lifesteal."
- **Message Type**: `MESSAGE_STATUS_DEFAULT` (white text at bottom of game window)

## Technical Details

### Type Safety
- Lifesteal stored as `uint32_t` (0 to 4,294,967,295)
- Practical range: 0-100 (percentage)
- Calculation uses integer arithmetic to avoid floating-point errors

### Performance
- Equipment scan: O(10) - constant time (only 10 slots)
- Minimal overhead: only executed when damage is dealt by a player
- No memory allocations during combat

### Compatibility
- Works with all damage types (physical, magical, elemental)
- Compatible with PvP and PvE combat
- Stacks additively with multiple items
- Independent of other healing mechanics

## Testing Recommendations

1. **Single Item Test**: Equip one item with lifesteal and verify healing
2. **Multiple Items Test**: Equip multiple items and verify lifesteal stacks
3. **Full Health Test**: Verify no message when already at full health
4. **Low Damage Test**: Verify healing with damage < 100
5. **High Damage Test**: Verify large damage amounts
6. **Item Description Test**: Verify lifesteal shows in item descriptions

## Future Enhancements (Optional)

Possible future improvements:
- Add lifesteal cap configuration option
- Add lifesteal combat effect animation
- Add lifesteal to Lua scripting API
- Add lifesteal statistics tracking
- Add visual healing effect when lifesteal triggers

## Notes

- The implementation uses the existing `getInventoryItem()` method
- Uses standard TFS message system for player feedback
- Follows PSR-12 PHP coding standards where applicable
- No database schema changes required
- No client modifications required

