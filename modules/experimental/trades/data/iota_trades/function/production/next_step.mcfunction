execute unless data storage iota_trades:scratch production.steps[0] run return 0
data modify storage iota_trades:scratch production.slot set from storage iota_trades:scratch production.steps[0].slot
data modify storage iota_trades:scratch production.direction set from storage iota_trades:scratch production.steps[0].direction
data modify storage iota_trades:scratch production.remaining set from storage iota_trades:scratch production.steps[0].candidates
data remove storage iota_trades:scratch production.selected
data modify storage iota_trades:scratch production.available set value []
data modify storage iota_trades:scratch production.bucketTotals set value {}
scoreboard players set #production_total it_identity_tmp 0
function iota_trades:production/next_candidate
data modify storage iota_trades:scratch production.remaining set from storage iota_trades:scratch production.available
function iota_trades:production/next_weighted
execute unless data storage iota_trades:scratch production.selected run return run data modify storage iota_trades:scratch production.failed set value 1b
data modify storage iota_trades:scratch production.variant_options set from storage iota_trades:scratch production.selected.variants
scoreboard players set #book_attempts it_identity_tmp 64
function iota_trades:production/select_variant
execute if data storage iota_trades:scratch production.failed run return 0
function iota_trades:production/save_slot with storage iota_trades:scratch production
data remove storage iota_trades:scratch production.steps[0]
function iota_trades:production/next_step
