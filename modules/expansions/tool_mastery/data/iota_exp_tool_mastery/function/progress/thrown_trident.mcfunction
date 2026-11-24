tag @s add iota_trident_checked
execute unless data entity @s item.components."minecraft:custom_data".iota_mastery.id run return 0
execute store result score #throw_id iota_mastery run data get entity @s item.components."minecraft:custom_data".iota_mastery.id
scoreboard players set #throw_damage iota_mastery 0
execute if data entity @s item.components."minecraft:damage" store result score #throw_damage iota_mastery run data get entity @s item.components."minecraft:damage"
data modify storage iota_tool_mastery:progress stack set from entity @s item
scoreboard players set #throw_ok iota_mastery 0
execute on origin if entity @s[type=minecraft:player,gamemode=survival] if score #throw_id iota_mastery = @s iota_hand_id run function iota_exp_tool_mastery:progress/credit_throw
execute unless score #throw_ok iota_mastery matches 1 run return 0
data modify entity @s item.components."minecraft:custom_data".iota_mastery.xp set from storage iota_tool_mastery:progress xp
data modify entity @s item.components."minecraft:custom_data".iota_mastery.xp_milli set from storage iota_tool_mastery:progress xp_milli
execute unless data entity @s item.components."minecraft:custom_data".iota_mastery{pending_throw:1b} run data modify entity @s item.components."minecraft:custom_data".iota_mastery.throw_previous_xp set from storage iota_tool_mastery:progress throw_previous_xp
data modify entity @s item.components."minecraft:custom_data".iota_mastery.pending_throw set value 1b
