execute store result score @s ed_found run data get storage iota_tool_mastery:progress level
$scoreboard players operation @s id_$(enchant) > @s ed_found
execute if data storage iota_tool_mastery:progress {enchant:"efficiency"} run scoreboard players operation @s ed_eff > @s ed_found

$scoreboard players operation #world id_$(enchant) > @s ed_found
