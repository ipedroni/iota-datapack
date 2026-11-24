scoreboard players set @s primitive_speed_target 0
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:wooden_pickaxe run scoreboard players set @s primitive_speed_target 1
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:wooden_axe run scoreboard players set @s primitive_speed_target 1
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:wooden_shovel run scoreboard players set @s primitive_speed_target 1
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:wooden_hoe run scoreboard players set @s primitive_speed_target 1
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:stone_pickaxe run scoreboard players set @s primitive_speed_target 2
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:stone_axe run scoreboard players set @s primitive_speed_target 2
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:stone_shovel run scoreboard players set @s primitive_speed_target 2
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:stone_hoe run scoreboard players set @s primitive_speed_target 2
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:netherite_pickaxe run scoreboard players set @s primitive_speed_target 3
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:netherite_axe run scoreboard players set @s primitive_speed_target 3
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:netherite_shovel run scoreboard players set @s primitive_speed_target 3
execute if score @s primitive_speed_enabled matches 1 if items entity @s weapon.mainhand minecraft:netherite_hoe run scoreboard players set @s primitive_speed_target 3
execute unless score @s primitive_speed_target = @s primitive_speed_state run function iota_tools:speed_transition
