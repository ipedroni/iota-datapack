execute store result score #bed it_identity_tmp run data get entity @s SleepTimer
execute if score #bed it_identity_tmp matches 99..100 unless score @s it_bed_seen matches 1 run function iota_trades:clock/sleep
execute if score #bed it_identity_tmp matches 99..100 run scoreboard players set @s it_bed_seen 1
execute if score #bed it_identity_tmp matches 0 run scoreboard players set @s it_bed_seen 0
