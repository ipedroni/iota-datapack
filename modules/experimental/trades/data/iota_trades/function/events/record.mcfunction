$data modify storage iota_trades:events last set value {merchant:$(id),kind:"$(kind)"}
data modify storage iota_trades:events last.player set from entity @s UUID
$execute as @e[type=minecraft:villager,tag=iota_trades_id.$(id),limit=1] store result storage iota_trades:events last.native_xp int 1 run data get entity @s Xp
$execute if data storage iota_trades:events last{kind:"trade"} if data storage iota_trades:residents r$(id){catalog:1b} run return run function iota_trades:catalog/trade {id:$(id)}
$execute if data storage iota_trades:events last{kind:"interact"} if data storage iota_trades:residents r$(id){catalog:1b} run function iota_trades:catalog/open {id:$(id)}
$execute if data storage iota_trades:events last{kind:"interact"} run data modify storage iota_trades:residents r$(id).accounted_xp set from storage iota_trades:events last.native_xp
$execute if data storage iota_trades:events last{kind:"trade"} run data modify storage iota_trades:scratch credit.id set value $(id)
execute if data storage iota_trades:events last{kind:"trade"} run data modify storage iota_trades:scratch credit.uuid set from entity @s UUID
execute if data storage iota_trades:events last{kind:"trade"} run function iota_trades:ledger/credit with storage iota_trades:scratch credit
