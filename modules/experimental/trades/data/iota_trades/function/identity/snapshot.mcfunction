$data modify storage iota_trades:residents r$(id).uuid set from entity @s UUID
$data modify storage iota_trades:residents r$(id).xp set from entity @s Xp
$execute if data entity @s Offers run data modify storage iota_trades:residents r$(id).native_offers set from entity @s Offers
execute store result score #level it_identity_tmp run data get entity @s VillagerData.level
execute unless entity @a[distance=..12] if score #level it_identity_tmp matches 2.. unless data entity @s CustomName run function iota_trades:identity/name
