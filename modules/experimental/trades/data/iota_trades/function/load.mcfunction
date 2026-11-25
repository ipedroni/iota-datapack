scoreboard objectives add it_identity dummy
scoreboard objectives add it_identity_tmp dummy
execute unless score #next it_identity matches 0.. run scoreboard players set #next it_identity 0

scoreboard objectives add it_far dummy
scoreboard objectives add it_bed_seen dummy
scoreboard players set #poll_period it_identity_tmp 20
execute unless score #poll_phase it_identity_tmp matches 0..19 run scoreboard players set #poll_phase it_identity_tmp 0
function iota_trades:catalog/templates
function iota_trades:catalog/current_templates
function iota_trades:production/pools
data modify storage iota_trades:templates workstations set value {armorer:"minecraft:blast_furnace",butcher:"minecraft:smoker",cartographer:"minecraft:cartography_table",cleric:"minecraft:brewing_stand",farmer:"minecraft:composter",fisherman:"minecraft:barrel",fletcher:"minecraft:fletching_table",leatherworker:"#minecraft:cauldrons",librarian:"minecraft:lectern",mason:"minecraft:stonecutter",shepherd:"minecraft:loom",toolsmith:"minecraft:smithing_table",weaponsmith:"minecraft:grindstone"}
function iota_trades_qual:load
