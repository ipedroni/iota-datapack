$execute unless entity @s[nbt={UUID:$(owner)}] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless data storage iota_hearts:xp work.record{active:1b} run return 0
function iota_hearts:xp/total
execute if score #level iota_x_math matches 21864.. run return 0
execute if score #total iota_x_math matches ..-1 run return 0
scoreboard players set #room iota_x_math 2147483647
scoreboard players operation #room iota_x_math -= #total iota_x_math
$scoreboard players set #claim iota_x_math $(amount)
execute if score #claim iota_x_math > #room iota_x_math run return 0
scoreboard players set #paid iota_x_math 0
$execute store success score #paid iota_x_math run experience add @s $(amount) points
execute unless score #paid iota_x_math matches 1 run return 0
data modify storage iota_hearts:xp work.record.active set value 0b
function iota_hearts:xp/save_record with storage iota_hearts:xp work
execute at @s run function iota_hearts:xp/pickup_feedback
