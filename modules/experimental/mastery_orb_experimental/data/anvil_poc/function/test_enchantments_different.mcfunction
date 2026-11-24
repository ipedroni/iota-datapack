# Test fixture: never overwrite occupied hands.
execute if items entity @s weapon.mainhand * run tellraw @s {"text":"[TEST] Empty your main hand first. No items changed.","color":"red"}
execute if items entity @s weapon.mainhand * run return fail
execute if items entity @s weapon.offhand * run tellraw @s {"text":"[TEST] Empty your offhand first. No items changed.","color":"red"}
execute if items entity @s weapon.offhand * run return fail
item replace entity @s weapon.mainhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:3000},other_pack:{keep_me:1b,serial:42}},minecraft:custom_name={text:"Primary Efficiency",color:"aqua",italic:false},minecraft:enchantments={"minecraft:efficiency":3,"minecraft:unbreaking":2},minecraft:damage=57,minecraft:lore=[{text:"Primary lore must remain",color:"gray",italic:false}]] 1
item replace entity @s weapon.offhand with minecraft:iron_pickaxe[minecraft:custom_data={anvil_poc:{test:1b,xp:2000},other_pack:{keep_me:1b,serial:42}},minecraft:custom_name={text:"Secondary Fortune",color:"aqua",italic:false},minecraft:enchantments={"minecraft:fortune":3,"minecraft:mending":1}] 1
tellraw @s {"text":"[TEST] Primary: Efficiency III + Unbreaking II, 3000 XP. Secondary: Fortune III + Mending, 2000 XP.","color":"aqua"}
tellraw @s {"text":"[TEST] Use the orb. Expected: primary 3500 XP with ONLY Efficiency III + Unbreaking II; offhand consumed. Check /function anvil_poc:test_enchantments_verify.","color":"yellow"}
