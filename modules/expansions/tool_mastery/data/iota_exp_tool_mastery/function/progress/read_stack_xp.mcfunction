# The integer XP field remains compatible with the 3.8.8 preview.
scoreboard players set #xp iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".anvil_poc.xp store result score #xp iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".anvil_poc.xp 1000
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.xp store result score #xp iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.xp 1000
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.xp_milli store result score #xp iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.xp_milli
execute if score #xp iota_mastery matches ..-1 run scoreboard players set #xp iota_mastery 0
