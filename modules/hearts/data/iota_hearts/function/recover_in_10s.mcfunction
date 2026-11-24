execute unless entity @s[type=minecraft:player] run return fail
execute unless function iota_hearts:recovery_active run return run function iota_hearts:no_recovery
execute unless score @s iota_l_ticks matches 5800.. run scoreboard players set @s iota_l_ticks 5800
function iota_hearts:display
