function iota_exp_tool_mastery:broken_equipment/tick
execute as @a run function iota_exp_tool_mastery:broken_poc_tick
execute as @a[scores={iota_m_sound=1..},nbt={Health:0.0f}] run scoreboard players set @s iota_m_sound 0
execute as @a[scores={iota_m_sound=1..}] unless entity @s[nbt={Health:0.0f}] run function iota_exp_tool_mastery:feedback/sound_tick
execute in minecraft:overworld as @e[type=minecraft:trident,tag=!iota_trident_checked] run function iota_exp_tool_mastery:progress/thrown_trident
execute in minecraft:the_nether as @e[type=minecraft:trident,tag=!iota_trident_checked] run function iota_exp_tool_mastery:progress/thrown_trident
execute in minecraft:the_end as @e[type=minecraft:trident,tag=!iota_trident_checked] run function iota_exp_tool_mastery:progress/thrown_trident
execute as @a[gamemode=survival] run function iota_exp_tool_mastery:tick_player
