# Leave the job intact when its origin is not loaded. A later tick can resume it.
$execute in $(dimension) positioned $(x) $(y) $(z) unless loaded ~ ~ ~ run return 0
scoreboard players remove #map_budget it_identity_tmp 1
$execute in $(dimension) positioned $(x) $(y) $(z) run function iota_trades:catalog/maps/next_choice
