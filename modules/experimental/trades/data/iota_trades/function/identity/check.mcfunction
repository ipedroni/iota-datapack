execute if data entity @s VillagerData{profession:"minecraft:none"} run return 0
execute if data entity @s VillagerData{profession:"minecraft:nitwit"} run return 0
data modify storage iota_trades:scratch tags set value []
data modify storage iota_trades:scratch tags set from entity @s Tags
execute if data storage iota_trades:scratch tags[0] run function iota_trades:identity/recover
execute if score @s it_identity matches 1.. run return 1
scoreboard players add #next it_identity 1
scoreboard players operation @s it_identity = #next it_identity
execute store result storage iota_trades:scratch args.id int 1 run scoreboard players get @s it_identity
function iota_trades:identity/initialize with storage iota_trades:scratch args
