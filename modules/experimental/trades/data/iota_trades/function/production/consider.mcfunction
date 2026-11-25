$scoreboard players set #production_weight it_identity_tmp $(weight)
$scoreboard players set #bucket_mass it_identity_tmp $(mass)
$execute store result score #bucket_weight it_identity_tmp run data get storage iota_trades:scratch production.bucketTotals.$(bucket)
execute if score #bucket_mass it_identity_tmp matches 1.. run scoreboard players operation #production_weight it_identity_tmp *= #bucket_mass it_identity_tmp
execute if score #bucket_mass it_identity_tmp matches 1.. run scoreboard players operation #production_weight it_identity_tmp /= #bucket_weight it_identity_tmp
execute if score #production_weight it_identity_tmp matches ..0 run scoreboard players set #production_weight it_identity_tmp 1
scoreboard players operation #production_total it_identity_tmp += #production_weight it_identity_tmp
execute store result storage iota_trades:scratch production.total int 1 run scoreboard players get #production_total it_identity_tmp
function iota_trades:production/draw with storage iota_trades:scratch production
execute if score #production_ticket it_identity_tmp <= #production_weight it_identity_tmp run data modify storage iota_trades:scratch production.selected set from storage iota_trades:scratch production.remaining[0]
