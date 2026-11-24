# Test fixture: never overwrite occupied hands.
execute if items entity @s weapon.mainhand * run tellraw @s {"text":"[TEST] Empty your main hand first. No items changed.","color":"red"}
execute if items entity @s weapon.mainhand * run return fail
execute if items entity @s weapon.offhand * run tellraw @s {"text":"[TEST] Empty your offhand first. No items changed.","color":"red"}
execute if items entity @s weapon.offhand * run return fail
item replace entity @s weapon.mainhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:3000},other_pack:{keep_me:1b,serial:42}},minecraft:custom_name={text:"Primary Silk Touch",color:"aqua",italic:false},minecraft:enchantments={"minecraft:silk_touch":1}] 1
item replace entity @s weapon.offhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:2000},other_pack:{keep_me:1b,serial:42}},minecraft:custom_name={text:"Secondary Fortune",color:"aqua",italic:false},minecraft:enchantments={"minecraft:fortune":3}] 1
tellraw @s {"text":"[TEST] Conflict case: Silk Touch primary, Fortune secondary. After transfer, only Silk Touch should remain; XP should be 3500.","color":"yellow"}
