data modify storage iota_trades:scratch production.available append from storage iota_trades:scratch production.remaining[0]
scoreboard players set #bucket_weight it_identity_tmp 0
$execute if data storage iota_trades:scratch production.bucketTotals.$(bucket) store result score #bucket_weight it_identity_tmp run data get storage iota_trades:scratch production.bucketTotals.$(bucket)
$scoreboard players add #bucket_weight it_identity_tmp $(weight)
$execute store result storage iota_trades:scratch production.bucketTotals.$(bucket) int 1 run scoreboard players get #bucket_weight it_identity_tmp
