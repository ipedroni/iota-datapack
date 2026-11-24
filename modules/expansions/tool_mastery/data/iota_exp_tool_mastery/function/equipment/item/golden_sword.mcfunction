scoreboard players set #refresh iota_mastery 1
data remove storage iota_tool_mastery:progress first_lore
data modify storage iota_tool_mastery:progress first_lore set from storage iota_tool_mastery:progress stack.components."minecraft:lore"[0]
execute if data storage iota_tool_mastery:progress first_lore{insertion:"iota:mastery_rank"} run scoreboard players set #refresh iota_mastery 0
scoreboard players add @s iota_u25 0
scoreboard players set #actions iota_mastery 0
execute if score #stable iota_mastery matches 1 run scoreboard players operation #actions iota_mastery = @s iota_u25
scoreboard players set @s iota_u25 0
scoreboard players set #reference iota_mastery 1
scoreboard players set #max_damage iota_mastery 1
scoreboard players set #cap iota_mastery 8000000
data modify storage iota_tool_mastery:progress curve set value "hand"
scoreboard players set #milestones iota_mastery 0
execute if score #actions iota_mastery matches 1.. run scoreboard players set #milestones iota_mastery 1
execute unless score #milestones iota_mastery matches 1 unless score #refresh iota_mastery matches 1 run return 0
execute unless score #actions iota_mastery matches 1.. run scoreboard players set #wear iota_mastery 0
data modify storage iota_tool_mastery:progress default_item_name set value {"translate":"item.minecraft.golden_sword"}
data modify storage iota_tool_mastery:progress reward_group set value "group_6"
function iota_exp_tool_mastery:progress/award with storage iota_tool_mastery:progress
