execute if items entity @s weapon.offhand * run tellraw @s {"text":"Esvazie a offhand antes de preparar este caso.","color":"red"}
execute if items entity @s weapon.offhand * run return fail
item replace entity @s weapon.offhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:0}}]
tellraw @s {"text":"Offhand preparada com 0 XP.","color":"green"}
