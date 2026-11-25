execute unless data storage iota_trades:scratch production.selected.variants[0] run return 0
execute store result score #production_ceiling it_identity_tmp run data get storage iota_trades:scratch production.selected.variants[0].ceiling
execute if score #production_variant it_identity_tmp <= #production_ceiling it_identity_tmp run return 1
data remove storage iota_trades:scratch production.selected.variants[0]
function iota_trades:production/next_variant
