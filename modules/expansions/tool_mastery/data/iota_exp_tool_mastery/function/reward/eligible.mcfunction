scoreboard players set #minimum iota_mastery 0
$execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:$(enchant)" store result score #minimum iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:$(enchant)"
scoreboard players add #minimum iota_mastery 1
$scoreboard players set #lower iota_mastery $(min)
$scoreboard players set #upper iota_mastery $(max)
scoreboard players operation #minimum iota_mastery > #lower iota_mastery
execute if score #minimum iota_mastery > #upper iota_mastery run return 0
$data modify storage iota_tool_mastery:progress candidate set value {enchant:"$(enchant)",max:$(max),weight:$(weight)}
execute store result storage iota_tool_mastery:progress candidate.min int 1 run scoreboard players get #minimum iota_mastery
$data modify storage iota_tool_mastery:progress $(pool) append from storage iota_tool_mastery:progress candidate
$scoreboard players add #$(pool) iota_mastery $(weight)
