$execute unless items entity @s $(slot) minecraft:shield[minecraft:blocks_attacks] run return 0
scoreboard players set #shield_rank iota_mastery 0
execute if score #xp iota_mastery matches 700..1499 run scoreboard players set #shield_rank iota_mastery 4
execute if score #xp iota_mastery matches 1500.. run scoreboard players set #shield_rank iota_mastery 5
execute if score #shield_rank iota_mastery matches 0 unless data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.shield_rank run return 0
scoreboard players set #old_shield_rank iota_mastery -1
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.shield_rank store result score #old_shield_rank iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.shield_rank
execute if score #old_shield_rank iota_mastery = #shield_rank iota_mastery run return 0
data modify storage iota_tool_mastery:progress blocking set value {"block_delay_seconds":0.25,"block_sound":"minecraft:item.shield.block","bypassed_by":"#minecraft:bypasses_shield","disabled_sound":"minecraft:item.shield.break","item_damage":{"base":1,"factor":1,"threshold":3}}
execute if data storage iota_tool_mastery:progress stack.components."minecraft:blocks_attacks" run data modify storage iota_tool_mastery:progress blocking set from storage iota_tool_mastery:progress stack.components."minecraft:blocks_attacks"
scoreboard players set #shield_base iota_mastery 10000
execute if data storage iota_tool_mastery:progress blocking.disable_cooldown_scale store result score #shield_base iota_mastery run data get storage iota_tool_mastery:progress blocking.disable_cooldown_scale 10000
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.shield_base store result score #shield_base iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.shield_base
execute store result storage iota_tool_mastery:progress shield_base int 1 run scoreboard players get #shield_base iota_mastery
execute store result storage iota_tool_mastery:progress shield_rank int 1 run scoreboard players get #shield_rank iota_mastery
scoreboard players set #shield_scale iota_mastery 100
execute if score #shield_rank iota_mastery matches 4 run scoreboard players set #shield_scale iota_mastery 90
execute if score #shield_rank iota_mastery matches 5 run scoreboard players set #shield_scale iota_mastery 80
scoreboard players operation #shield_scale iota_mastery *= #shield_base iota_mastery
execute store result storage iota_tool_mastery:progress blocking.disable_cooldown_scale float 0.000001 run scoreboard players get #shield_scale iota_mastery
function iota_exp_tool_mastery:shield/apply_cooldown with storage iota_tool_mastery:progress
