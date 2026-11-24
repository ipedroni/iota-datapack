scoreboard players set #pick iota_mastery 1
$scoreboard players set #pool_range iota_mastery $(pool_weight)
$execute if score #pool_range iota_mastery matches 2.. store result score #pick iota_mastery run random value 1..$(pool_weight)
function iota_exp_tool_mastery:reward/next with storage iota_tool_mastery:progress
