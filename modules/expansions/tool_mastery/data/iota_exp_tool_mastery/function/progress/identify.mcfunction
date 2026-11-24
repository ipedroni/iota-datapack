scoreboard players add #next_id iota_mastery 1
execute store result storage iota_tool_mastery:progress id int 1 run scoreboard players get #next_id iota_mastery
$execute store success score #identified iota_mastery run item modify entity @s $(slot) iota_exp_tool_mastery:identify
execute if score #identified iota_mastery matches 1 run scoreboard players operation #id iota_mastery = #next_id iota_mastery
