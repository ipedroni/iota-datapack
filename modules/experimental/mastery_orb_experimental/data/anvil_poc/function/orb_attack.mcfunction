# Run as the attacker, positioned at the station by caller.
# In Creative remove without a drop; in Survival/Adventure drop the orb.
execute if entity @s[gamemode=creative] run function anvil_poc:orb_break_creative
execute unless entity @s[gamemode=creative] run function anvil_poc:orb_break_survival
