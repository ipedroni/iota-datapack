execute unless score #book_attempts it_identity_tmp matches 1.. run return run data modify storage iota_trades:scratch production.failed set value 1b
scoreboard players remove #book_attempts it_identity_tmp 1
data modify storage iota_trades:scratch production.selected.variants set from storage iota_trades:scratch production.variant_options
function iota_trades:production/roll_variant with storage iota_trades:scratch production.selected
function iota_trades:production/next_variant
execute if data storage iota_trades:scratch production.selected.variants[0].signature run function iota_trades:production/book_signature with storage iota_trades:scratch production.selected.variants[0]
