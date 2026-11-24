function iota_exp_tool_mastery:progress/read_stack_xp
scoreboard players operation #previous_xp iota_mastery = #xp iota_mastery
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery{pending_throw:1b} if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.throw_previous_xp store result score #previous_xp iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.throw_previous_xp
data remove storage iota_tool_mastery:progress notification_reward
data remove storage iota_tool_mastery:progress notification_level
data modify storage iota_tool_mastery:progress pending_throw set value 0b
execute if score #actions iota_mastery matches 101.. run scoreboard players set #actions iota_mastery 100
execute if score #wear iota_mastery matches 101.. run scoreboard players set #wear iota_mastery 100
scoreboard players operation #actions iota_mastery *= #1000 iota_mastery
scoreboard players operation #wear iota_mastery *= #250 iota_mastery
scoreboard players operation #actions iota_mastery += #wear iota_mastery
scoreboard players operation #actions iota_mastery *= #reference iota_mastery
scoreboard players operation #max_damage iota_mastery > #one iota_mastery
scoreboard players operation #actions iota_mastery /= #max_damage iota_mastery
scoreboard players operation #xp iota_mastery += #actions iota_mastery
scoreboard players operation #xp iota_mastery < #cap iota_mastery
execute store result storage iota_tool_mastery:progress xp_milli int 1 run scoreboard players get #xp iota_mastery
scoreboard players operation #xp iota_mastery /= #1000 iota_mastery
execute store result storage iota_tool_mastery:progress xp int 1 run scoreboard players get #xp iota_mastery
scoreboard players set #processed iota_mastery 2
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.processed store result score #processed iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.processed
$return run function iota_exp_tool_mastery:progress/curve_$(curve) with storage iota_tool_mastery:progress
