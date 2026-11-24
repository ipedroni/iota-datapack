execute if items entity @s weapon.mainhand *[minecraft:custom_data~{iota_broken_equipment:{broken:1b}}] run return 0
data remove storage iota_tool_mastery:progress stack
data modify storage iota_tool_mastery:progress stack set from entity @s SelectedItem
execute unless data storage iota_tool_mastery:progress stack.id run return 0
data modify storage iota_tool_mastery:progress slot set value "weapon.mainhand"
data modify storage iota_tool_mastery:progress previous_id set value "iota_hand_id"
data modify storage iota_tool_mastery:progress previous_damage set value "iota_hand_dmg"
scoreboard players set #damage iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:damage" store result score #damage iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:damage"
scoreboard players set #id iota_mastery 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id store result score #id iota_mastery run data get storage iota_tool_mastery:progress stack.components."minecraft:custom_data".iota_mastery.id
execute unless score #id iota_mastery matches 1.. run function iota_exp_tool_mastery:progress/identify with storage iota_tool_mastery:progress
execute unless score #id iota_mastery matches 1.. run return 0
function iota_exp_tool_mastery:progress/wear with storage iota_tool_mastery:progress
data modify storage iota_tool_mastery:progress shield_hand set value 1b
data modify storage iota_tool_mastery:progress shield_hits set value "iota_block_hand"
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:shield"} run function iota_exp_tool_mastery:shield/mark_hand with storage iota_tool_mastery:progress
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:wooden_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/wooden_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:wooden_axe"} run return run function iota_exp_tool_mastery:equipment/item/wooden_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:wooden_shovel"} run return run function iota_exp_tool_mastery:equipment/item/wooden_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:wooden_hoe"} run return run function iota_exp_tool_mastery:equipment/item/wooden_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:wooden_sword"} run return run function iota_exp_tool_mastery:equipment/item/wooden_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:stone_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/stone_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:stone_axe"} run return run function iota_exp_tool_mastery:equipment/item/stone_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:stone_shovel"} run return run function iota_exp_tool_mastery:equipment/item/stone_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:stone_hoe"} run return run function iota_exp_tool_mastery:equipment/item/stone_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:stone_sword"} run return run function iota_exp_tool_mastery:equipment/item/stone_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/copper_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_axe"} run return run function iota_exp_tool_mastery:equipment/item/copper_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_shovel"} run return run function iota_exp_tool_mastery:equipment/item/copper_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_hoe"} run return run function iota_exp_tool_mastery:equipment/item/copper_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:copper_sword"} run return run function iota_exp_tool_mastery:equipment/item/copper_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/iron_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_axe"} run return run function iota_exp_tool_mastery:equipment/item/iron_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_shovel"} run return run function iota_exp_tool_mastery:equipment/item/iron_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_hoe"} run return run function iota_exp_tool_mastery:equipment/item/iron_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:iron_sword"} run return run function iota_exp_tool_mastery:equipment/item/iron_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/golden_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_axe"} run return run function iota_exp_tool_mastery:equipment/item/golden_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_shovel"} run return run function iota_exp_tool_mastery:equipment/item/golden_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_hoe"} run return run function iota_exp_tool_mastery:equipment/item/golden_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:golden_sword"} run return run function iota_exp_tool_mastery:equipment/item/golden_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/diamond_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_axe"} run return run function iota_exp_tool_mastery:equipment/item/diamond_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_shovel"} run return run function iota_exp_tool_mastery:equipment/item/diamond_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_hoe"} run return run function iota_exp_tool_mastery:equipment/item/diamond_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:diamond_sword"} run return run function iota_exp_tool_mastery:equipment/item/diamond_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_pickaxe"} run return run function iota_exp_tool_mastery:equipment/item/netherite_pickaxe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_axe"} run return run function iota_exp_tool_mastery:equipment/item/netherite_axe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_shovel"} run return run function iota_exp_tool_mastery:equipment/item/netherite_shovel
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_hoe"} run return run function iota_exp_tool_mastery:equipment/item/netherite_hoe
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:netherite_sword"} run return run function iota_exp_tool_mastery:equipment/item/netherite_sword
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:bow"} run return run function iota_exp_tool_mastery:equipment/item/bow
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:crossbow"} run return run function iota_exp_tool_mastery:equipment/item/crossbow
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:trident"} run return run function iota_exp_tool_mastery:equipment/item/trident
execute if data storage iota_tool_mastery:progress stack{id:"minecraft:shield"} run return run function iota_exp_tool_mastery:equipment/item/shield
