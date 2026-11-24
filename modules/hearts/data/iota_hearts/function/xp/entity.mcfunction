function iota_hearts:xp/context
data remove storage iota_hearts:xp work.record
function iota_hearts:xp/read_record with storage iota_hearts:xp work
execute unless data storage iota_hearts:xp work.record{active:1b} run return run kill @s
execute store result score #valid_gen iota_x_math run data get storage iota_hearts:xp work.record.gen
execute unless score @s iota_x_gen = #valid_gen iota_x_math run return run kill @s
execute unless entity @s[tag=iota_x_named] run function iota_hearts:xp/name
execute if entity @s[type=minecraft:interaction] run function iota_hearts:xp/interact
