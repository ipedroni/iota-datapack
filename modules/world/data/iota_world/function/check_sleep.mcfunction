scoreboard players set #players iota_world 0
scoreboard players set #sleepers iota_world 0
scoreboard players set #hundred iota_world 100
execute as @a[gamemode=!spectator] if dimension minecraft:overworld run scoreboard players add #players iota_world 1
execute as @a[gamemode=!spectator] if dimension minecraft:overworld store result score @s iota_world run data get entity @s SleepTimer
execute as @a[gamemode=!spectator] if dimension minecraft:overworld if score @s iota_world matches 99..100 run scoreboard players add #sleepers iota_world 1
execute unless score #sleepers iota_world matches 1.. run return 0
execute store result score #percent iota_world run gamerule minecraft:players_sleeping_percentage
scoreboard players operation #players iota_world *= #percent iota_world
scoreboard players operation #sleepers iota_world *= #hundred iota_world
execute unless score #sleepers iota_world >= #players iota_world run return 0
weather clear
execute if score #time iota_world matches 12000..23999 run function iota_world:dawn
execute if score #time iota_world matches 0..11999 run time add 3000
