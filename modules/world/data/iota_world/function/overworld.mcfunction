scoreboard players add #step iota_world 1
execute if score #step iota_world matches 6.. run time add 1
execute if score #step iota_world matches 6.. run scoreboard players set #step iota_world 0
execute store result score #time iota_world run time query daytime
execute if entity @a[distance=0..,gamemode=!spectator,nbt={SleepTimer:99s}] run function iota_world:check_sleep
