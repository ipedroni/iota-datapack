data merge entity @s {Invisible:1b,Marker:1b,Invulnerable:1b}
$loot replace entity @s weapon.mainhand loot $(table)
execute if data entity @s equipment.mainhand{id:"minecraft:filled_map"} if data entity @s equipment.mainhand.components."minecraft:map_id" if data entity @s equipment.mainhand.components."minecraft:map_decorations" run function iota_trades:catalog/maps/save
item replace entity @s weapon.mainhand with air
kill @s
