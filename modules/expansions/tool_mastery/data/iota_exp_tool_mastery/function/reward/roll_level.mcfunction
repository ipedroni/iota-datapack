$data modify storage iota_tool_mastery:progress enchant set value "$(enchant)"
$data modify storage iota_tool_mastery:progress level set value $(min)
$scoreboard players set #roll_min iota_mastery $(min)
$scoreboard players set #roll_max iota_mastery $(max)
$execute if score #roll_min iota_mastery < #roll_max iota_mastery store result storage iota_tool_mastery:progress level int 1 run random value $(min)..$(max)
function iota_exp_tool_mastery:reward/apply with storage iota_tool_mastery:progress
