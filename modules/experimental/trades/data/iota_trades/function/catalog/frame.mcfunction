execute if entity @a[distance=..12] run scoreboard players set @s it_far 0
execute unless entity @a[distance=..12] run scoreboard players add @s it_far 1
execute store result storage iota_trades:scratch frame.id int 1 run scoreboard players get @s it_identity
function iota_trades:clock/frame with storage iota_trades:scratch frame
execute if score @s it_far matches 60.. run function iota_trades:catalog/publish_if_dirty with storage iota_trades:scratch frame
