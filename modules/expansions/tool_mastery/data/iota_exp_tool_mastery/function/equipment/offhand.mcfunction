execute if items entity @s weapon.offhand *[minecraft:custom_data~{iota_broken_equipment:{broken:1b}}] run return 0
data remove storage iota_tool_mastery:progress stack
data modify storage iota_tool_mastery:progress stack set from entity @s equipment.offhand
execute unless data storage iota_tool_mastery:progress stack.id run return 0
data modify storage iota_tool_mastery:progress slot set value "weapon.offhand"
data modify storage iota_tool_mastery:progress previous_id set value "iota_offhand_id"
data modify storage iota_tool_mastery:progress previous_damage set value "iota_offhand_dmg"
scoreboard players set #damage iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:damage" store result score #damage iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:damage"
scoreboard players set #id iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id store result score #id iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id
execute unless score #id iota_mastery matches 1.. run function iota_exp_tool_mastery:progress/identify with storage iota_tool_mastery:progress
execute unless score #id iota_mastery matches 1.. run return 0
function iota_exp_tool_mastery:progress/wear with storage iota_tool_mastery:progress
data modify storage iota_tool_mastery:progress shield_hand set value 2b
data modify storage iota_tool_mastery:progress shield_hits set value "iota_block_offhand"
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:shield"} run function iota_exp_tool_mastery:shield/mark_hand with storage iota_tool_mastery:progress
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:shield"} run return run function iota_exp_tool_mastery:equipment/item/shield
