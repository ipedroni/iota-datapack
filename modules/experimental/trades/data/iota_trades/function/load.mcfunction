scoreboard objectives add it_identity dummy
scoreboard objectives add it_identity_tmp dummy
execute unless score #next it_identity matches 0.. run scoreboard players set #next it_identity 0

scoreboard objectives add it_far dummy
scoreboard objectives add it_bed_seen dummy
function iota_trades:catalog/templates
function iota_trades_qual:load
