execute store result score #mason_group it_identity_tmp run random value 0..1
execute if score #mason_group it_identity_tmp matches 0 run data modify storage iota_trades:scratch init.pool set value "mason_stonemason"
execute if score #mason_group it_identity_tmp matches 0 run data modify storage iota_trades:scratch production.sale_group set value "stonemason"
execute if score #mason_group it_identity_tmp matches 1 run data modify storage iota_trades:scratch init.pool set value "mason_ceramist"
execute if score #mason_group it_identity_tmp matches 1 run data modify storage iota_trades:scratch production.sale_group set value "ceramist"
