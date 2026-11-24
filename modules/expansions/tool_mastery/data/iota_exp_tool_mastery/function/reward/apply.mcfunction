scoreboard players set #reward_failed iota_mastery 1
execute store result score #reward_level iota_mastery run data get storage iota_tool_mastery:progress level
execute unless score #reward_level iota_mastery matches 1.. run return 0
$execute store success score #enchant_ok iota_mastery run item modify entity @s $(slot) {function:"minecraft:set_enchantments",enchantments:{"minecraft:$(enchant)":$(level)},add:false}
execute unless score #enchant_ok iota_mastery matches 1 run return 0
$execute unless items entity @s $(slot) *[minecraft:enchantments~[{enchantments:"minecraft:$(enchant)",levels:$(level)}]] run return 0
scoreboard players set #reward_failed iota_mastery 0
$data modify storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:$(enchant)" set value $(level)
$data modify storage iota_tool_mastery:progress notification_reward set value {enchant:"$(enchant)",level:$(level)}
function #iota_exp_tool_mastery:reward_applied
