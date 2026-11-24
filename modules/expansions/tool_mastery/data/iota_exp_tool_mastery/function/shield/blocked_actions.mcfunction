scoreboard players set #actions iota_mastery 0
$execute if score #stable iota_mastery matches 1 if score @s $(shield_hits) matches 1.. run scoreboard players operation #actions iota_mastery = @s $(shield_hits)
