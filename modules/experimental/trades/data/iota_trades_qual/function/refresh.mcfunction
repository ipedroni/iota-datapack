scoreboard players set @s iota_qbusy 1
advancement revoke @s only iota_trades_qual:open_merchant
scoreboard players add @s iota_qpoc 1
scoreboard players set #qual_optional iota_qpoc 0
execute if entity @e[type=minecraft:villager,tag=iota_trades_current_probe,tag=iota_trades_catalog,distance=..8] run scoreboard players set #qual_optional iota_qpoc 1
execute if entity @e[type=minecraft:villager,tag=iota_trades_production_test,tag=iota_trades_catalog,distance=..8] run scoreboard players set #qual_optional iota_qpoc 1
execute if items entity @s hotbar.0 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.0","nbt":"Inventory[{Slot:0b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.1 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.1","nbt":"Inventory[{Slot:1b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.2 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.2","nbt":"Inventory[{Slot:2b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.3 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.3","nbt":"Inventory[{Slot:3b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.4 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.4","nbt":"Inventory[{Slot:4b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.5 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.5","nbt":"Inventory[{Slot:5b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.6 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.6","nbt":"Inventory[{Slot:6b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.7 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.7","nbt":"Inventory[{Slot:7b}].components.\"minecraft:enchantments\""}
execute if items entity @s hotbar.8 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"hotbar.8","nbt":"Inventory[{Slot:8b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.0 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.0","nbt":"Inventory[{Slot:9b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.1 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.1","nbt":"Inventory[{Slot:10b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.2 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.2","nbt":"Inventory[{Slot:11b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.3 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.3","nbt":"Inventory[{Slot:12b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.4 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.4","nbt":"Inventory[{Slot:13b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.5 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.5","nbt":"Inventory[{Slot:14b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.6 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.6","nbt":"Inventory[{Slot:15b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.7 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.7","nbt":"Inventory[{Slot:16b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.8 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.8","nbt":"Inventory[{Slot:17b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.9 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.9","nbt":"Inventory[{Slot:18b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.10 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.10","nbt":"Inventory[{Slot:19b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.11 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.11","nbt":"Inventory[{Slot:20b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.12 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.12","nbt":"Inventory[{Slot:21b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.13 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.13","nbt":"Inventory[{Slot:22b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.14 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.14","nbt":"Inventory[{Slot:23b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.15 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.15","nbt":"Inventory[{Slot:24b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.16 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.16","nbt":"Inventory[{Slot:25b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.17 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.17","nbt":"Inventory[{Slot:26b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.18 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.18","nbt":"Inventory[{Slot:27b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.19 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.19","nbt":"Inventory[{Slot:28b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.20 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.20","nbt":"Inventory[{Slot:29b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.21 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.21","nbt":"Inventory[{Slot:30b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.22 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.22","nbt":"Inventory[{Slot:31b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.23 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.23","nbt":"Inventory[{Slot:32b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.24 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.24","nbt":"Inventory[{Slot:33b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.25 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.25","nbt":"Inventory[{Slot:34b}].components.\"minecraft:enchantments\""}
execute if items entity @s inventory.26 #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"inventory.26","nbt":"Inventory[{Slot:35b}].components.\"minecraft:enchantments\""}
execute if items entity @s weapon.offhand #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"weapon.offhand","nbt":"equipment.offhand.components.\"minecraft:enchantments\""}
execute if items entity @s armor.head #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"armor.head","nbt":"equipment.head.components.\"minecraft:enchantments\""}
execute if items entity @s armor.chest #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"armor.chest","nbt":"equipment.chest.components.\"minecraft:enchantments\""}
execute if items entity @s armor.legs #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"armor.legs","nbt":"equipment.legs.components.\"minecraft:enchantments\""}
execute if items entity @s armor.feet #iota_trades_qual:equipment run function iota_trades_qual:refresh_slot {"slot":"armor.feet","nbt":"equipment.feet.components.\"minecraft:enchantments\""}
scoreboard players set @s iota_qbusy 0
