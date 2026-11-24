$execute store success score #mark_ok iota_mastery run item modify entity @s $(slot) iota_exp_tool_mastery:mark_reward
$execute if score #mark_ok iota_mastery matches 1 run scoreboard players set #processed iota_mastery $(milestone)
