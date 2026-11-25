$data modify storage iota_trades:scratch production.picked.s$(slot) set from storage iota_trades:scratch production.selected.key
$data modify storage iota_trades:scratch production.rolled.o$(slot) set value {kind:0,direction:"$(direction)"}
$data modify storage iota_trades:scratch production.rolled.o$(slot).item set from storage iota_trades:scratch production.selected.item
$data modify storage iota_trades:scratch production.rolled.o$(slot).level set from storage iota_trades:scratch production.selected.level
$data modify storage iota_trades:scratch production.rolled.o$(slot).xp set from storage iota_trades:scratch production.selected.xp
$execute if data storage iota_trades:scratch production.selected.variants[0].native run data modify storage iota_trades:scratch production.rolled.o$(slot).native set from storage iota_trades:scratch production.selected.variants[0].native
$execute if data storage iota_trades:scratch production{direction:"sell"} run data modify storage iota_trades:scratch production.sales append value $(slot)
$execute if data storage iota_trades:scratch production{direction:"buy"} run data modify storage iota_trades:scratch production.buys append value $(slot)
