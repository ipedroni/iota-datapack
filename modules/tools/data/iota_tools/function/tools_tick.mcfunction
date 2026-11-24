execute as @a unless score @s primitive_speed_enabled matches 0..1 run scoreboard players set @s primitive_speed_enabled 1
execute as @a run function iota_tools:speed_tick
execute as @a run function iota_tools:properties_tick

execute as @a run function iota_tools:repair_tick

execute as @a run function iota_tools:clear_prior_work
execute as @a run function iota_tools:remove_curses
