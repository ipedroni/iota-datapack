execute unless data storage iota_tool_mastery:progress pool[0] run return 0
execute store result score #weight iota_mastery run data get storage iota_tool_mastery:progress pool[0].weight
scoreboard players operation #pick iota_mastery -= #weight iota_mastery
execute if score #pick iota_mastery matches ..0 run return run function iota_exp_tool_mastery:reward/roll_level with storage iota_tool_mastery:progress pool[0]
data remove storage iota_tool_mastery:progress pool[0]
function iota_exp_tool_mastery:reward/next with storage iota_tool_mastery:progress
