# Read-only: verify primary enchantments and absence of secondary-only enchants.
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe run tellraw @s {"text":"[FAIL] Main hand is not an iron pickaxe.","color":"red"}
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe run return fail
execute if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":3,"enchantments":"minecraft:efficiency"},{"levels":2,"enchantments":"minecraft:unbreaking"}]] run tellraw @s {"text":"[PASS] Primary enchantments remain Efficiency III + Unbreaking II.","color":"green"}
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":3,"enchantments":"minecraft:efficiency"},{"levels":2,"enchantments":"minecraft:unbreaking"}]] run tellraw @s {"text":"[FAIL] Expected primary enchantments missing.","color":"red"}
execute if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":3,"enchantments":"minecraft:fortune"}]] run tellraw @s {"text":"[FAIL] Secondary Fortune was transferred unexpectedly.","color":"red"}
execute if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":1,"enchantments":"minecraft:mending"}]] run tellraw @s {"text":"[FAIL] Secondary Mending was transferred unexpectedly.","color":"red"}
execute unless items entity @s weapon.offhand * run tellraw @s {"text":"[PASS] Offhand is empty.","color":"green"}
execute if items entity @s weapon.offhand * run tellraw @s {"text":"[CHECK] Offhand still contains an item.","color":"yellow"}
execute store result score @s ap_verify run data get entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp 1
execute if score @s ap_verify matches 3500 run tellraw @s {"text":"[PASS] Primary XP is 3500.","color":"green"}
execute unless score @s ap_verify matches 3500 run tellraw @s [{"text":"[CHECK] Primary XP is ","color":"yellow"},{"score":{"name":"@s","objective":"ap_verify"}},{"text":" (expected 3500)."}]
tellraw @s {"text":"[CHECK] Inspect all primary components below: name, lore, damage, custom_data and enchantments.","color":"gray"}
data get entity @s SelectedItem.components
