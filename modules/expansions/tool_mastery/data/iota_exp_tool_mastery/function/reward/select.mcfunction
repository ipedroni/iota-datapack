$data modify storage iota_tool_mastery:progress pool set from storage iota_tool_mastery:progress $(pool)
$execute store result storage iota_tool_mastery:progress pool_weight int 1 run scoreboard players get #$(pool) iota_mastery
function iota_exp_tool_mastery:reward/roll_pool with storage iota_tool_mastery:progress
