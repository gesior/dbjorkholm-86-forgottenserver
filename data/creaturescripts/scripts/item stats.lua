local config = {
    maxDecreasePercents = 99,
    slots = {
        [CONST_SLOT_HEAD] = SLOTP_HEAD,
        [CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
        [CONST_SLOT_BACKPACK] = CONST_SLOT_BACKPACK,
        [CONST_SLOT_ARMOR] = SLOTP_ARMOR,
        [CONST_SLOT_LEGS] = SLOTP_LEGS,
        [CONST_SLOT_FEET] = SLOTP_FEET,
        [CONST_SLOT_AMMO] = SLOTP_AMMO,
        [CONST_SLOT_RING] = SLOTP_RING,
    },

    items = {
        [17413] = {decreaseDamage = 4, combats = {COMBAT_ENERGYDAMAGE}}, -- Golden Frieza 
        [17409] = {increaseDamage = 4, combats = {COMBAT_ENERGYDAMAGE}}, -- Lost Saiyan 
        [17406] = {decreaseDamage = 4, combats = {COMBAT_PHYSICALDAMAGE}}, -- Goku SSJ5 
        [13528] = {decreaseDamage = 4, increaseDamage = 4, combats = {COMBAT_ENERGYDAMAGE, COMBAT_PHYSICALDAMAGE}} -- God 
    }
} 

local function getPercentsChange(player, damageType, combatType)
    local percents = 0
    if not player:isPlayer() or not damageType or not combatType then
        return percents
    end

    for slot, position in pairs(config.slots) do
        local slotItem = player:getSlotItem(slot)
        if slotItem then
            local itemType = ItemType(slotItem.itemid)
            if itemType then
                if (itemType:getSlotPosition() - SLOTP_LEFT - SLOTP_RIGHT) == position then
                    local playerItem = config.items[slotItem.itemid]
                    if playerItem then
                        local damage = playerItem[damageType]
                        if damage and table.contains(playerItem.combats, combatType) then
                            percents = percents + damage
                        end
                    end
                end
            end
        end
    end

    return percents
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    -- increaseDamage
    if attacker then
        local percents = getPercentsChange(attacker, "increaseDamage", primaryType)
        if percents > 0 then
            primaryDamage = primaryDamage + ((percents / 100) * primaryDamage)
        end
    end

    -- decreaseDamage
    if creature then
        local percents = getPercentsChange(creature, "decreaseDamage", primaryType)
        if percents > 0 then
            primaryDamage = primaryDamage - ((math.min(percents, config.maxDecreasePercents) / 100) * primaryDamage)
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end