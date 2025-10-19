local specialItems = {
    [12029] = {PercentDamage = 7}, --Golden Cyber Potara
    [12030] = {PercentDamage = 7}, --Golden Cyber Armor
    [12031] = {PercentDamage = 7}, --Golden Cyber Legs
    [12032] = {PercentDamage = 7}, --Golden Cyber Boots
    [12023] = {PercentDamage = 7}, --Golden Hawkeye Potara
    [12024] = {PercentDamage = 7}, --Golden Hawkeye Armor
    [12025] = {PercentDamage = 7}, --Golden Hawkeye Legs
    [12026] = {PercentDamage = 7}, --Golden Hawkeye Boots
    [15773] = {PercentDamage = 6}, --Elite Patroler Potara
    [15781] = {PercentDamage = 6}, -- Elite Patroler Armor
    [15782] = {PercentDamage = 6}, -- Elite Patroler Legs
    [15783] = {PercentDamage = 6}, -- Elite Patroler Boots
    [15792] = {PercentDamage = 3}, -- Elite Patroler Amulet
    [15791] = {PercentDamage = 3}, -- Elite Patroler Ring
    [1526] = {PercentDamage = 5}, -- Kai Ring
    [13807] = {PercentDamage = 2}, -- Demigra Band
    [13804] = {PercentDamage = 5}, -- Demigra Boots
    [13803] = {PercentDamage = 5}, -- Demigra Legs
    [13802] = {PercentDamage = 5}, -- Demigra Armor
    [13801] = {PercentDamage = 5}, -- Demigra Headband
    [13805] = {PercentDamage = 3}, -- Demigra Belt
    [13387] = {PercentDamage = 3}, --Dragon Ring
    [13388] = {PercentDamage = 3} --Lost Warrior Ring
}


-- add more slots to check here
local checkslots = {
    CONST_SLOT_RING,
    CONST_SLOT_NECKLACE,
    CONST_SLOT_LEGS,
    CONST_SLOT_ARMOR,
    CONST_SLOT_HEAD,
    CONST_SLOT_FEET
}

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if creature and attacker then
        if attacker:isPlayer() then
            local extraDmg = 0
            for i = 1,#checkslots do
                local slotitem = attacker:getSlotItem(checkslots[i])
                if slotitem and primaryType == COMBAT_ENERGYDAMAGE then
                    for k,v in pairs(specialItems) do
                        if k == slotitem.itemid then
                            -- add up all combined extraDmg here (if wearing multiple specialItems)
                            extraDmg = extraDmg + ((v.PercentDamage / 100) * primaryDamage)
                        end
                    end
                end
            end
            -- add combined extraDmg here
            primaryDamage = primaryDamage + extraDmg
        end
    end
return primaryDamage, primaryType, secondaryDamage, secondaryType
end