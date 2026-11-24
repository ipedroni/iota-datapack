execute unless entity @s[type=minecraft:player] run return fail
give @s minecraft:diamond_pickaxe[minecraft:custom_data={iota_mastery:{xp:7999,processed:4}},minecraft:custom_name={text:"Mastery V Test"}]
tellraw @s {"text":"Select the test pickaxe in Survival and mine one stone block.","color":"gray"}
