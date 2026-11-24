execute in minecraft:overworld run execute as @e[type=minecraft:villager] at @s unless score @s it_identity matches 1.. run function iota_trades:identity/check
execute in minecraft:overworld run execute as @e[type=minecraft:villager] at @s if score @s it_identity matches 1.. run function iota_trades:identity/watch
execute in minecraft:the_nether run execute as @e[type=minecraft:villager] at @s unless score @s it_identity matches 1.. run function iota_trades:identity/check
execute in minecraft:the_nether run execute as @e[type=minecraft:villager] at @s if score @s it_identity matches 1.. run function iota_trades:identity/watch
execute in minecraft:the_end run execute as @e[type=minecraft:villager] at @s unless score @s it_identity matches 1.. run function iota_trades:identity/check
execute in minecraft:the_end run execute as @e[type=minecraft:villager] at @s if score @s it_identity matches 1.. run function iota_trades:identity/watch

execute as @a at @s run function iota_trades:clock/sleep_detect
function iota_trades_qual:tick
execute in minecraft:overworld as @e[type=villager,tag=iota_trades_catalog_probe,scores={it_identity=1..64}] at @s run function iota_trades:catalog/watch
