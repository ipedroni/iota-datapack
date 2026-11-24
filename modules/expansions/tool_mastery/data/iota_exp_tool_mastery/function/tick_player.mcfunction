execute if score @s iota_armor_cd matches 1.. run scoreboard players remove @s iota_armor_cd 1
execute unless items entity @s weapon.mainhand #iota_exp_tool_mastery:hand_equipment run scoreboard players reset @s iota_hand_id
execute if items entity @s weapon.mainhand #iota_exp_tool_mastery:hand_equipment run function iota_exp_tool_mastery:equipment/hand
execute unless items entity @s weapon.offhand #iota_exp_tool_mastery:offhand_equipment run scoreboard players reset @s iota_offhand_id
execute if items entity @s weapon.offhand #iota_exp_tool_mastery:offhand_equipment run function iota_exp_tool_mastery:equipment/offhand
execute unless items entity @s armor.head #iota_exp_tool_mastery:head_equipment run scoreboard players reset @s iota_head_id
execute if items entity @s armor.head #iota_exp_tool_mastery:head_equipment run function iota_exp_tool_mastery:equipment/head
execute unless items entity @s armor.chest #iota_exp_tool_mastery:chest_equipment run scoreboard players reset @s iota_chest_id
execute if items entity @s armor.chest #iota_exp_tool_mastery:chest_equipment run function iota_exp_tool_mastery:equipment/chest
execute unless items entity @s armor.legs #iota_exp_tool_mastery:legs_equipment run scoreboard players reset @s iota_legs_id
execute if items entity @s armor.legs #iota_exp_tool_mastery:legs_equipment run function iota_exp_tool_mastery:equipment/legs
execute unless items entity @s armor.feet #iota_exp_tool_mastery:feet_equipment run scoreboard players reset @s iota_feet_id
execute if items entity @s armor.feet #iota_exp_tool_mastery:feet_equipment run function iota_exp_tool_mastery:equipment/feet
scoreboard players set @s iota_armor_hit 0
scoreboard players set @s iota_shield_active 0
scoreboard players set @s iota_block_hand 0
scoreboard players set @s iota_block_offhand 0
scoreboard players set @s iota_stone 0
scoreboard players set @s iota_iron 0
