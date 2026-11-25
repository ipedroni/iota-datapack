execute unless data storage iota_trades:scratch maps.slots[0] run return 0
data modify storage iota_trades:scratch maps.slot set from storage iota_trades:scratch maps.slots[0].slot
data modify storage iota_trades:scratch maps.choices set from storage iota_trades:scratch maps.slots[0].choices
data modify storage iota_trades:scratch maps.found set value []
