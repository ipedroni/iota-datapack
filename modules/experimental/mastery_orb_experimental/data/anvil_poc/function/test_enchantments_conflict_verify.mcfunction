execute if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":1,"enchantments":"minecraft:silk_touch"}]] run tellraw @s {"text":"[PASS] Silk Touch preserved.","color":"green"}
execute unless items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":1,"enchantments":"minecraft:silk_touch"}]] run tellraw @s {"text":"[FAIL] Silk Touch missing.","color":"red"}
execute if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:enchantments~[{"levels":3,"enchantments":"minecraft:fortune"}]] run tellraw @s {"text":"[FAIL] Fortune was copied unexpectedly.","color":"red"}
execute store result score @s ap_verify run data get entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp 1
execute if score @s ap_verify matches 3500 run tellraw @s {"text":"[PASS] 3500 XP.","color":"green"}
execute unless items entity @s weapon.offhand * run tellraw @s {"text":"[PASS] Secondary consumed.","color":"green"}
data get entity @s SelectedItem.components
