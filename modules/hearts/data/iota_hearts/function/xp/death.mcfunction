function iota_hearts:xp/total
execute if score #level iota_x_math matches 21864.. run return run function iota_hearts:xp/out_of_range
execute if score #total iota_x_math matches ..-1 run return run function iota_hearts:xp/out_of_range
scoreboard players operation #loss iota_x_math = #total iota_x_math
scoreboard players operation #loss iota_x_math /= #4 iota_x_math
scoreboard players operation #keep iota_x_math = #total iota_x_math
scoreboard players operation #keep iota_x_math -= #loss iota_x_math
scoreboard players add @s iota_x_gen 1
function iota_hearts:xp/context
data modify storage iota_hearts:xp work.record set value {active:0b,placed:0b}
data modify storage iota_hearts:xp work.record.owner set from entity @s UUID
data modify storage iota_hearts:xp work.record.gen set from storage iota_hearts:xp work.gen
execute store result storage iota_hearts:xp work.record.amount int 1 run scoreboard players get #loss iota_x_math
execute store result storage iota_hearts:xp work.record.keep int 1 run scoreboard players get #keep iota_x_math
data modify storage iota_hearts:xp work.record.death set from entity @s LastDeathLocation
execute store result storage iota_hearts:xp work.record.grounded byte 1 run scoreboard players get @s iota_x_ground
function iota_hearts:xp/save_record with storage iota_hearts:xp work
scoreboard players set @s iota_x_wait 1
scoreboard players set @s iota_x_dead 0
