execute unless data storage iota_trades:scratch refill.order[0] run return 0
data modify storage iota_trades:scratch refill.slot set from storage iota_trades:scratch refill.order[0]
function iota_trades:clock/refill_slot with storage iota_trades:scratch refill
data remove storage iota_trades:scratch refill.order[0]
function iota_trades:clock/refill_next
