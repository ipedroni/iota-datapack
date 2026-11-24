scoreboard objectives add iota_l_deaths deathCount
scoreboard objectives add iota_l_lost dummy
scoreboard objectives add iota_l_ticks dummy
scoreboard objectives add iota_l_math dummy
scoreboard players set #20 iota_l_math 20
scoreboard players set #60 iota_l_math 60
execute in minecraft:overworld run gamerule minecraft:keep_inventory true
execute in minecraft:the_nether run gamerule minecraft:keep_inventory true
execute in minecraft:the_end run gamerule minecraft:keep_inventory true

scoreboard objectives add iota_h_probe dummy
scoreboard objectives add iota_h_near dummy
scoreboard objectives add iota_h_hud dummy
scoreboard objectives add iota_h_fx dummy

scoreboard players set #100 iota_l_math 100
function iota_hearts:xp/load
