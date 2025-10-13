# Lifesteal Attribute - Quick Start Guide

## What is Lifesteal?
Lifesteal allows players to recover health when they deal damage. If an item has 5% lifesteal and the player deals 100 damage, they heal for 5 HP.

## Adding Lifesteal to Items

### Step 1: Open items.xml
Navigate to `data/items/items.xml`

### Step 2: Add the lifesteal attribute
Add this line to any item definition:
```xml
<attribute key="lifesteal" value="5"/>
```

### Step 3: Example Complete Item
```xml
<item id="2400" name="vampiric sword">
    <attribute key="weight" value="4000"/>
    <attribute key="attack" value="35"/>
    <attribute key="defense" value="20"/>
    <attribute key="weapontype" value="sword"/>
    <attribute key="slottype" value="hand"/>
    <attribute key="lifesteal" value="5"/>
</item>
```

## Important Notes

### Lifesteal Stacking
- Lifesteal from multiple equipped items STACKS
- Example: 5% weapon + 3% ring + 2% armor = 10% total lifesteal

### Value Range
- Use whole numbers (0-100)
- Value represents percentage
- Example: `value="5"` means 5% lifesteal

### Message Display
Players will see: **"You gained X hitpoint(s) from lifesteal."**
- Only shown when they actually gain health
- Shows real healing amount (respects max health)

### Item Description
When players look at an item with lifesteal, they see:
```
vampiric sword (Atk:35, Def:20, lifesteal +5%)
```

## Quick Examples

### Low Lifesteal (1-3%)
Good for common items or secondary equipment:
```xml
<attribute key="lifesteal" value="2"/>
```

### Medium Lifesteal (4-7%)
Good for rare weapons or jewelry:
```xml
<attribute key="lifesteal" value="5"/>
```

### High Lifesteal (8-15%)
Good for legendary/unique items:
```xml
<attribute key="lifesteal" value="10"/>
```

## Testing Your Changes

1. **Reload the server** after editing items.xml
2. **Get the item** in-game
3. **Look at the item** - you should see "lifesteal +X%"
4. **Equip the item** and attack a monster
5. **Watch for the message** - "You gained X hitpoint(s) from lifesteal."

## Troubleshooting

### Item doesn't show lifesteal in description
- Check XML syntax (proper closing tags, quotes)
- Verify the item ID is correct
- Restart the server

### No healing message appears
- Make sure you're dealing damage
- Check if you're already at full health
- Verify the item is equipped (not just in inventory)

### Healing amount seems wrong
- Remember: healing = (damage × lifesteal%) / 100
- Multiple equipped items with lifesteal stack
- Healing is capped by missing health

## Example Scenarios

### Scenario 1: Single Item
- Equipment: Sword with 5% lifesteal
- Action: Deal 100 damage
- Result: Heal for 5 HP
- Message: "You gained 5 hitpoints from lifesteal."

### Scenario 2: Multiple Items
- Equipment: Sword (5%) + Ring (3%) + Armor (2%)
- Total: 10% lifesteal
- Action: Deal 100 damage
- Result: Heal for 10 HP
- Message: "You gained 10 hitpoints from lifesteal."

### Scenario 3: Full Health
- Equipment: Sword with 5% lifesteal
- Current: 100/100 HP
- Action: Deal 100 damage (would heal 5)
- Result: Stay at 100/100 HP
- Message: No message (already full health)

### Scenario 4: Partial Healing
- Equipment: Sword with 5% lifesteal
- Current: 95/100 HP (missing 5)
- Action: Deal 200 damage (would heal 10)
- Result: Heal to 100/100 HP (only +5)
- Message: "You gained 5 hitpoints from lifesteal."

## Recommended Item IDs for Testing

You can use these unused item IDs for testing:
- 9001-9999: Usually available for custom items
- Check your items.xml to find unused IDs

Example test item:
```xml
<item id="9001" name="test vampiric blade">
    <attribute key="weight" value="2000"/>
    <attribute key="attack" value="50"/>
    <attribute key="weapontype" value="sword"/>
    <attribute key="slottype" value="hand"/>
    <attribute key="lifesteal" value="10"/>
</item>
```

## Support

If you encounter issues:
1. Check server console for errors
2. Verify XML syntax
3. Review LIFESTEAL_IMPLEMENTATION.md for technical details
4. Check that all modified source files compiled successfully

