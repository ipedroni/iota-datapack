scoreboard players set #xp iota_mastery 0
execute if data entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp store result score #xp iota_mastery run data get entity @s SelectedItem.components."minecraft:custom_data".anvil_poc.xp 1
execute if data entity @s SelectedItem.components."minecraft:custom_data".iota_mastery.xp store result score #xp iota_mastery run data get entity @s SelectedItem.components."minecraft:custom_data".iota_mastery.xp 1
execute if score #xp iota_mastery matches ..-1 run scoreboard players set #xp iota_mastery 0
