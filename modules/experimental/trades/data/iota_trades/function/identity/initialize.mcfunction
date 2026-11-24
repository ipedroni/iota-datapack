$tag @s add iota_trades_id.$(id)
$data modify storage iota_trades:residents r$(id).profession set from entity @s VillagerData.profession
$data modify storage iota_trades:residents r$(id).bootstrap set value 0b
$execute if data entity @s {Xp:0} run data modify storage iota_trades:residents r$(id).bootstrap set value 1b
execute if data entity @s {Xp:0} run data merge entity @s {Xp:1}
$data modify storage iota_trades:residents r$(id).uuid set from entity @s UUID
$data modify storage iota_trades:residents r$(id).players set value []
$data modify storage iota_trades:residents r$(id).accounted_xp set from entity @s Xp
