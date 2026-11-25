execute unless data storage iota_trades:scratch poll.slots[0] run return 0
data modify storage iota_trades:scratch poll.slot set from storage iota_trades:scratch poll.slots[0]
execute store result storage iota_trades:scratch poll.index int 1 run scoreboard players get #poll_index it_identity_tmp
function iota_trades:catalog/poll_slot with storage iota_trades:scratch poll
data remove storage iota_trades:scratch poll.slots[0]
scoreboard players add #poll_index it_identity_tmp 1
function iota_trades:catalog/poll_next
