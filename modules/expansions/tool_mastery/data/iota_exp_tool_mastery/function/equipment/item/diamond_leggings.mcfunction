scoreboard players set #refresh iota_mastery 1
data remove storage iota_tool_mastery:progress first_lore
data modify storage iota_tool_mastery:progress first_lore set from storage iota_tool_mastery:progress stack.components."minecraft:lore"[0]
execute if data storage iota_tool_mastery:progress first_lore{insertion:"iota:mastery_rank"} run scoreboard players set #refresh iota_mastery 0
scoreboard players set #actions iota_mastery 0
execute if score @s iota_armor_hit matches 1 if score #stable iota_mastery matches 1 run scoreboard players set #actions iota_mastery 1
scoreboard players set #reference iota_mastery 528
scoreboard players set #max_damage iota_mastery 495
execute if data storage iota_tool_mastery:progress stack.components."minecraft:max_damage" store result score #max_damage iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:max_damage"
scoreboard players set #cap iota_mastery 1500000
data modify storage iota_tool_mastery:progress curve set value "armor"
scoreboard players set #milestones iota_mastery 0
execute if score #actions iota_mastery matches 1.. run scoreboard players set #milestones iota_mastery 1
execute unless score #milestones iota_mastery matches 1 unless score #refresh iota_mastery matches 1 run return 0
execute unless score #actions iota_mastery matches 1.. run scoreboard players set #wear iota_mastery 0
data modify storage iota_tool_mastery:progress default_item_name set value {"translate":"item.minecraft.diamond_leggings"}
data modify storage iota_tool_mastery:progress reward_group set value "group_16"
function iota_exp_tool_mastery:progress/award with storage iota_tool_mastery:progress
