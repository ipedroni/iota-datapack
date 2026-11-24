execute store result score #chance iota_mastery run random value 1..1000
$scoreboard players set #rare_odds iota_mastery $(rare_odds)
execute if score #rare iota_mastery matches 1.. if score #chance iota_mastery <= #rare_odds iota_mastery run return run function iota_exp_tool_mastery:reward/select {pool:"rare"}
execute if score #common iota_mastery matches 1.. run return run function iota_exp_tool_mastery:reward/select {pool:"common"}
# Preserve the Treasure probability when only Treasure outcomes remain.
return 0
