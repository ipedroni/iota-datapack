tellraw @s {"text":"[Hearts] Vida maxima total, base e atributos salvos:","color":"yellow"}
attribute @s minecraft:max_health get
attribute @s minecraft:max_health base get
data get entity @s attributes
scoreboard players get @s iota_l_lost
scoreboard players get @s iota_l_ticks
