scoreboard players set @s iota_u38 0
scoreboard players operation #throw_damage iota_mastery -= @s iota_hand_dmg
execute if score #throw_damage iota_mastery matches ..-1 run scoreboard players set #throw_damage iota_mastery 0
execute if score #throw_damage iota_mastery matches 101.. run scoreboard players set #throw_damage iota_mastery 100
function iota_exp_tool_mastery:progress/read_stack_xp
execute store result storage iota_tool_mastery:progress throw_previous_xp int 1 run scoreboard players get #xp iota_mastery
scoreboard players operation #throw_damage iota_mastery *= #250 iota_mastery
scoreboard players add #xp iota_mastery 1000
scoreboard players operation #xp iota_mastery += #throw_damage iota_mastery
execute if score #xp iota_mastery matches 8000001.. run scoreboard players set #xp iota_mastery 8000000
execute store result storage iota_tool_mastery:progress xp_milli int 1 run scoreboard players get #xp iota_mastery
scoreboard players operation #xp iota_mastery /= #1000 iota_mastery
execute store result storage iota_tool_mastery:progress xp int 1 run scoreboard players get #xp iota_mastery
scoreboard players set #throw_ok iota_mastery 1
