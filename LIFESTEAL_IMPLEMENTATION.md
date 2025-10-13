# Lifesteal Implementation Guide

## Overview
The lifesteal attribute has been successfully implemented for The Forgotten Server. This feature allows items to grant players a percentage of health recovery based on the damage they deal to creatures.

## Implementation Details

### 1. Files Modified

#### src/enums.h
- Added `ITEM_ATTRIBUTE_LIFESTEAL = 1 << 23` to the `itemAttrTypes` enum

#### src/item.h
- Updated `isIntAttrType()` mask to include the new lifesteal attribute (0xFFFFE13)

#### src/items.h
- Added `lifestealPercent` field (int16_t) to the `Abilities` struct
- Initialized to 0 in the constructor

#### src/items.cpp
- Added XML parsing for "lifesteal" attribute in `parseItemNode()`
- Example: `<attribute key="lifesteal" value="10" />` for 10% lifesteal

#### src/item.cpp
- Added lifesteal display in item descriptions for both weapons and armor
- Shows as: `lifesteal +X%` in item description

#### src/game.cpp
- Implemented lifesteal healing in `combatChangeHealth()`
- Calculates total lifesteal from all equipped items
- Heals player based on damage dealt
- Sends message showing actual health gained

## How to Use

### Adding Lifesteal to Items in items.xml

Add the lifesteal attribute to any item that should grant lifesteal:

```xml
<!-- Example: Vampire Sword with 5% lifesteal -->
<item id="2400" name="vampire sword">
    <attribute key="weaponType" value="sword" />
    <attribute key="attack" value="35" />
    <attribute key="defense" value="20" />
    <attribute key="lifesteal" value="5" />
</item>

<!-- Example: Helmet with 2% lifesteal -->
<item id="2458" name="helmet of vitality">
    <attribute key="slotType" value="head" />
    <attribute key="armor" value="10" />
    <attribute key="lifesteal" value="2" />
</item>

<!-- Example: Ring with 3% lifesteal -->
<item id="2166" name="vampire ring">
    <attribute key="slotType" value="ring" />
    <attribute key="lifesteal" value="3" />
</item>
```

### How It Works

1. **Equipment**: When a player equips items with the lifesteal attribute, the values are stored in each item's abilities.

2. **Combat**: When the player deals damage to a creature:
   - The system calculates the total lifesteal percentage from all equipped items
   - Formula: `heal_amount = (damage_dealt * total_lifesteal_percent) / 100`
   - The player is healed by the calculated amount (capped at max health)

3. **Message**: Only when the player actually gains health (not at full HP):
   - Player receives: "You gained X hitpoint(s) from lifesteal."
   - Uses `MESSAGE_STATUS_DEFAULT` message type

4. **Display**: When examining an item with lifesteal:
   - Shows in description: `(lifesteal +5%)` or similar
   - Appears alongside other attributes like armor, defense, protection, speed

### Examples

#### Single Item (5% lifesteal)
- Player deals 100 damage
- Heals for: 100 × 5% = 5 HP
- Message: "You gained 5 hitpoints from lifesteal."

#### Multiple Items (5% + 3% + 2% = 10% total)
- Player deals 150 damage
- Total lifesteal: 10%
- Heals for: 150 × 10% = 15 HP
- Message: "You gained 15 hitpoints from lifesteal."

#### At Max Health
- Player deals 200 damage with 10% lifesteal
- Already at max HP
- No healing occurs, no message sent

#### Partial Healing
- Player has 990/1000 HP
- Player deals 200 damage with 10% lifesteal
- Calculated heal: 20 HP
- Actual heal: 10 HP (capped at max)
- Message: "You gained 10 hitpoints from lifesteal."

## Technical Notes

1. **Percentage Value**: The lifesteal value is stored as an int16_t (signed 16-bit integer)
   - Can be positive (healing) or negative (if you want reverse effect)
   - Recommended range: 0-100% for balance

2. **Stacking**: Lifesteal from multiple items stacks additively
   - 5% + 3% + 2% = 10% total lifesteal

3. **Calculation**: Uses ceiling rounding (std::ceil) to ensure minimum 1 HP on small heals
   - 1 damage with 10% lifesteal = 1 HP (rounds up from 0.1)

4. **Player Only**: Only works when the attacker is a player
   - Monsters with lifesteal items won't trigger healing (design choice)

5. **Message Type**: Uses MESSAGE_STATUS_DEFAULT (orange text in default client)
   - Only sent when actual healing occurs
   - Shows real health gained (respects max HP cap)

## Testing

To test the implementation:

1. Add a lifesteal item to items.xml (see examples above)
2. Restart the server or reload items
3. Give the item to a player: `/i [item_id]`
4. Equip the item
5. Look at the item to verify lifesteal is shown in description
6. Attack a creature and verify healing and message

## Performance Considerations

- Minimal performance impact
- Only iterates through equipped slots (10 slots maximum)
- Only processes when damage is actually dealt
- No additional database queries or complex calculations

## Future Enhancements (Optional)

If desired, the system could be extended to:
- Add lifesteal cap per item or total
- Add different types (mana steal, etc.)
- Add visual effects when lifesteal triggers
- Make it work for monsters/NPCs
- Add combat log entry for lifesteal healing

