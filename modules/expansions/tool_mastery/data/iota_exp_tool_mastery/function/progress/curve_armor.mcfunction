scoreboard players set #xp_written iota_mastery 0
data remove storage iota_tool_mastery:progress first_lore
data modify storage iota_tool_mastery:progress first_lore set from storage iota_tool_mastery:progress stack.components."minecraft:lore"[0]
execute if score #xp iota_mastery matches 0..4 run function iota_exp_tool_mastery:progress/lore_armor_0 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 5..99 run function iota_exp_tool_mastery:progress/lore_armor_1 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 100..299 run function iota_exp_tool_mastery:progress/lore_armor_2 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 300..699 run function iota_exp_tool_mastery:progress/lore_armor_3 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 700..1499 run function iota_exp_tool_mastery:progress/lore_armor_4 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 1500.. run function iota_exp_tool_mastery:progress/lore_armor_5 with storage iota_tool_mastery:progress
execute unless score #xp_written iota_mastery matches 1 run return 0
execute unless score #milestones iota_mastery matches 1 run return 0
scoreboard players set #reward_failed iota_mastery 0
execute if score #xp iota_mastery matches 300.. if score #processed iota_mastery matches ..2 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_3 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 700.. if score #processed iota_mastery matches ..3 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_4 with storage iota_tool_mastery:progress
execute if score #xp iota_mastery matches 1500.. if score #processed iota_mastery matches ..4 unless score #reward_failed iota_mastery matches 1 run function iota_exp_tool_mastery:reward/milestone_5 with storage iota_tool_mastery:progress
execute if score #previous_xp iota_mastery matches ..4999 if score #xp iota_mastery matches 5.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Rookie","rank":1}
execute if score #previous_xp iota_mastery matches ..99999 if score #xp iota_mastery matches 100.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Apprentice","rank":2}
execute if score #previous_xp iota_mastery matches ..299999 if score #xp iota_mastery matches 300.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Adept","rank":3}
execute if score #previous_xp iota_mastery matches ..699999 if score #xp iota_mastery matches 700.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Expert","rank":4}
execute if score #previous_xp iota_mastery matches ..1499999 if score #xp iota_mastery matches 1500.. run data modify storage iota_tool_mastery:progress notification_level set value {"label":"Masterwork","rank":5}
execute if data storage iota_tool_mastery:progress notification_level run return run function iota_exp_tool_mastery:feedback/level_up
