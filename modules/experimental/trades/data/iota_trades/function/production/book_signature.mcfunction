$execute if data storage iota_trades:scratch production.books[{signature:"$(signature)"}] run return run function iota_trades:production/select_variant
$data modify storage iota_trades:scratch production.books append value {signature:"$(signature)"}
