execute if entity @a[distance=..12] run scoreboard players set @s it_far 0
execute unless entity @a[distance=..12] run scoreboard players add @s it_far 1
execute store result storage iota_trades:scratch frame.id int 1 run scoreboard players get @s it_identity
execute if entity @s[tag=iota_trades_map_work] if score #map_budget it_identity_tmp matches 1.. run function iota_trades:catalog/maps/work with storage iota_trades:scratch frame
execute if entity @s[tag=iota_trades_current_probe,scores={it_identity=65..}] run function iota_trades:catalog/poll_if_due
execute if entity @s[tag=iota_trades_production_test,tag=!iota_trades_current_probe,scores={it_identity=65..}] run function iota_trades:catalog/poll_if_due
function iota_trades:clock/frame with storage iota_trades:scratch frame
execute if score @s it_far matches 60.. run function iota_trades:catalog/publish_if_dirty with storage iota_trades:scratch frame
