scoreboard objectives add iota_qpoc dummy
scoreboard objectives add iota_qbusy dummy
execute as @a unless score @s iota_qbusy matches 0..1 run scoreboard players set @s iota_qbusy 0
