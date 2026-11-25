execute unless score #new_only it_identity_tmp matches 1 as @e[type=minecraft:villager] at @s unless score @s it_identity matches 1.. run function iota_trades:identity/check
execute unless score #new_only it_identity_tmp matches 1 as @e[type=minecraft:villager] at @s if score @s it_identity matches 1.. run function iota_trades:identity/watch
execute if score #new_only it_identity_tmp matches 1 as @e[type=minecraft:villager,tag=iota_trades_production_test] at @s unless score @s it_identity matches 1.. run function iota_trades:identity/check
execute if score #new_only it_identity_tmp matches 1 as @e[type=minecraft:villager,tag=iota_trades_production_test,scores={it_identity=1..}] at @s run function iota_trades:identity/watch

execute as @a at @s run function iota_trades:clock/sleep_detect
function iota_trades_qual:tick
scoreboard players set #map_budget it_identity_tmp 1
scoreboard players add #poll_phase it_identity_tmp 1
scoreboard players operation #poll_phase it_identity_tmp %= #poll_period it_identity_tmp
execute unless score #new_only it_identity_tmp matches 1 as @e[type=villager,tag=iota_trades_catalog_probe,tag=!iota_trades_current_probe,scores={it_identity=1..64}] at @s run function iota_trades:catalog/watch
execute unless score #new_only it_identity_tmp matches 1 as @e[type=villager,tag=iota_trades_current_probe,scores={it_identity=1..}] at @s run function iota_trades:catalog/watch
execute as @e[type=villager,tag=iota_trades_production_test,scores={it_identity=1..}] at @s run function iota_trades:catalog/watch
