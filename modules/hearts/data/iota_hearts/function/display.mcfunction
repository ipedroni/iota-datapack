scoreboard players set #seconds iota_l_math 6000
scoreboard players operation #seconds iota_l_math -= @s iota_l_ticks
execute if score @s iota_h_near matches 1 run scoreboard players add #seconds iota_l_math 99
execute if score @s iota_h_near matches 1 run scoreboard players operation #seconds iota_l_math /= #100 iota_l_math
execute unless score @s iota_h_near matches 1 run scoreboard players add #seconds iota_l_math 19
execute unless score @s iota_h_near matches 1 run scoreboard players operation #seconds iota_l_math /= #20 iota_l_math
scoreboard players operation #minutes iota_l_math = #seconds iota_l_math
scoreboard players operation #minutes iota_l_math /= #60 iota_l_math
scoreboard players operation #seconds iota_l_math %= #60 iota_l_math
execute store result storage iota_hearts:display minutes int 1 run scoreboard players get #minutes iota_l_math
execute store result storage iota_hearts:display seconds int 1 run scoreboard players get #seconds iota_l_math
execute if score #seconds iota_l_math matches ..9 run return run function iota_hearts:show_padded with storage iota_hearts:display
function iota_hearts:show with storage iota_hearts:display
