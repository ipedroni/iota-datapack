# XP needed to reach current level, plus current-level points (not XpTotal).
execute store result score #level iota_x_math run experience query @s levels
execute store result score #progress iota_x_math run experience query @s points
scoreboard players operation #a iota_x_math = #level iota_x_math
scoreboard players operation #b iota_x_math = #level iota_x_math
execute if score #level iota_x_math matches ..16 run scoreboard players add #b iota_x_math 6
execute if score #level iota_x_math matches 17..31 run scoreboard players operation #b iota_x_math *= #5 iota_x_math
execute if score #level iota_x_math matches 17..31 run scoreboard players remove #b iota_x_math 81
execute if score #level iota_x_math matches 32.. run scoreboard players operation #b iota_x_math *= #9 iota_x_math
execute if score #level iota_x_math matches 32.. run scoreboard players remove #b iota_x_math 325
scoreboard players operation #parity iota_x_math = #a iota_x_math
scoreboard players operation #parity iota_x_math %= #2 iota_x_math
execute if score #level iota_x_math matches 17.. if score #parity iota_x_math matches 0 run scoreboard players operation #a iota_x_math /= #2 iota_x_math
execute if score #level iota_x_math matches 17.. if score #parity iota_x_math matches 1 run scoreboard players operation #b iota_x_math /= #2 iota_x_math
scoreboard players operation #total iota_x_math = #a iota_x_math
scoreboard players operation #total iota_x_math *= #b iota_x_math
execute if score #level iota_x_math matches 17..31 run scoreboard players add #total iota_x_math 360
execute if score #level iota_x_math matches 32.. run scoreboard players add #total iota_x_math 2220
scoreboard players operation #total iota_x_math += #progress iota_x_math
