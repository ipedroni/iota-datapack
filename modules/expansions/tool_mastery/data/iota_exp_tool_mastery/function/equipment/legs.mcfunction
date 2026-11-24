execute if items entity @s armor.legs *[minecraft:custom_data~{iota_broken_equipment:{broken:1b}}] run return 0
data remove storage iota_tool_mastery:progress stack
data modify storage iota_tool_mastery:progress stack set from entity @s equipment.legs
execute unless data storage iota_tool_mastery:progress stack.id run return 0
data modify storage iota_tool_mastery:progress slot set value "armor.legs"
data modify storage iota_tool_mastery:progress previous_id set value "iota_legs_id"
data modify storage iota_tool_mastery:progress previous_damage set value "iota_legs_dmg"
scoreboard players set #damage iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:damage" store result score #damage iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:damage"
scoreboard players set #id iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id store result score #id iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id
execute unless score #id iota_mastery matches 1.. run function iota_exp_tool_mastery:progress/identify with storage iota_tool_mastery:progress
execute unless score #id iota_mastery matches 1.. run return 0
function iota_exp_tool_mastery:progress/wear with storage iota_tool_mastery:progress
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:leather_leggings"} run return run function iota_exp_tool_mastery:equipment/item/leather_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:chainmail_leggings"} run return run function iota_exp_tool_mastery:equipment/item/chainmail_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_leggings"} run return run function iota_exp_tool_mastery:equipment/item/copper_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_leggings"} run return run function iota_exp_tool_mastery:equipment/item/iron_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_leggings"} run return run function iota_exp_tool_mastery:equipment/item/golden_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_leggings"} run return run function iota_exp_tool_mastery:equipment/item/diamond_leggings
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_leggings"} run return run function iota_exp_tool_mastery:equipment/item/netherite_leggings
