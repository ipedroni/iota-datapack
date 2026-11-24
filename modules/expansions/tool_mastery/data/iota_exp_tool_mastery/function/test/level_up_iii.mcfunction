execute unless entity @s[type=minecraft:player] run return fail
give @s minecraft:diamond_pickaxe[minecraft:custom_data={iota_mastery:{xp:1599,processed:2}},minecraft:custom_name={text:"Mastery III Test"}]
tellraw @s {"text":"Select the test pickaxe in Survival and mine one stone block.","color":"gray"}
