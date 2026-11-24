scoreboard players set #stable iota_mastery 0
scoreboard players set #wear iota_mastery 0
$execute if score #id iota_mastery = @s $(previous_id) run scoreboard players set #stable iota_mastery 1
execute if score #stable iota_mastery matches 1 run scoreboard players operation #wear iota_mastery = #damage iota_mastery
$execute if score #stable iota_mastery matches 1 run scoreboard players operation #wear iota_mastery -= @s $(previous_damage)
execute if score #wear iota_mastery matches ..-1 run scoreboard players set #wear iota_mastery 0
$scoreboard players operation @s $(previous_id) = #id iota_mastery
$scoreboard players operation @s $(previous_damage) = #damage iota_mastery
