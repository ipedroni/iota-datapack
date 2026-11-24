execute if items entity @s weapon.mainhand * run tellraw @s {"text":"Esvazie a mao principal.","color":"red"}
execute if items entity @s weapon.mainhand * run return fail
item replace entity @s weapon.mainhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:8000}}]
tellraw @s {"text":"Principal com 8000 XP equipada. Equipe a secundaria com /function anvil_poc:case_999 e clique na orbe.","color":"green"}
