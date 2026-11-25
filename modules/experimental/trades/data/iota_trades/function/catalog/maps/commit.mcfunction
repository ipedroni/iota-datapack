$data modify storage iota_trades:residents r$(id).rolled.o$(slot).native set from storage iota_trades:scratch maps.found[$(index)].native
$data modify storage iota_trades:residents r$(id).rolled.o$(slot).item set value "minecraft:filled_map"
$data modify storage iota_trades:residents r$(id).rolled.o$(slot).destination set from storage iota_trades:scratch maps.found[$(index)].destination
data modify storage iota_trades:scratch maps.used append value {}
$data modify storage iota_trades:scratch maps.used[-1].destination set from storage iota_trades:scratch maps.found[$(index)].destination
