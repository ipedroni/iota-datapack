execute store success score #had_data im_broken run data get storage iota_broken:scratch item.components."minecraft:custom_data"
execute store success score #had_ench im_broken run data get storage iota_broken:scratch item.components."minecraft:enchantments"
data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment set value {broken:1b,saved:{}}
execute store result storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.had_data byte 1 run scoreboard players get #had_data im_broken
execute store result storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.had_ench byte 1 run scoreboard players get #had_ench im_broken
execute if data storage iota_broken:scratch item.components."minecraft:equippable" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:equippable" set from storage iota_broken:scratch item.components."minecraft:equippable"
execute if data storage iota_broken:scratch item.components."!minecraft:equippable" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:equippable" set value {}
data remove storage iota_broken:scratch item.components."minecraft:equippable"
data modify storage iota_broken:scratch item.components."!minecraft:equippable" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:attribute_modifiers" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:attribute_modifiers" set from storage iota_broken:scratch item.components."minecraft:attribute_modifiers"
execute if data storage iota_broken:scratch item.components."!minecraft:attribute_modifiers" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:attribute_modifiers" set value {}
data remove storage iota_broken:scratch item.components."minecraft:attribute_modifiers"
data modify storage iota_broken:scratch item.components."!minecraft:attribute_modifiers" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:tool" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tool" set from storage iota_broken:scratch item.components."minecraft:tool"
execute if data storage iota_broken:scratch item.components."!minecraft:tool" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:tool" set value {}
data remove storage iota_broken:scratch item.components."minecraft:tool"
data modify storage iota_broken:scratch item.components."!minecraft:tool" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:weapon" set from storage iota_broken:scratch item.components."minecraft:weapon"
execute if data storage iota_broken:scratch item.components."!minecraft:weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:weapon"
data modify storage iota_broken:scratch item.components."!minecraft:weapon" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:kinetic_weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:kinetic_weapon" set from storage iota_broken:scratch item.components."minecraft:kinetic_weapon"
execute if data storage iota_broken:scratch item.components."!minecraft:kinetic_weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:kinetic_weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:kinetic_weapon"
data modify storage iota_broken:scratch item.components."!minecraft:kinetic_weapon" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:piercing_weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:piercing_weapon" set from storage iota_broken:scratch item.components."minecraft:piercing_weapon"
execute if data storage iota_broken:scratch item.components."!minecraft:piercing_weapon" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:piercing_weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:piercing_weapon"
data modify storage iota_broken:scratch item.components."!minecraft:piercing_weapon" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:blocks_attacks" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:blocks_attacks" set from storage iota_broken:scratch item.components."minecraft:blocks_attacks"
execute if data storage iota_broken:scratch item.components."!minecraft:blocks_attacks" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:blocks_attacks" set value {}
data remove storage iota_broken:scratch item.components."minecraft:blocks_attacks"
data modify storage iota_broken:scratch item.components."!minecraft:blocks_attacks" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:glider" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:glider" set from storage iota_broken:scratch item.components."minecraft:glider"
execute if data storage iota_broken:scratch item.components."!minecraft:glider" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:glider" set value {}
data remove storage iota_broken:scratch item.components."minecraft:glider"
data modify storage iota_broken:scratch item.components."!minecraft:glider" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:charged_projectiles" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:charged_projectiles" set from storage iota_broken:scratch item.components."minecraft:charged_projectiles"
execute if data storage iota_broken:scratch item.components."!minecraft:charged_projectiles" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:charged_projectiles" set value {}
data remove storage iota_broken:scratch item.components."minecraft:charged_projectiles"
data modify storage iota_broken:scratch item.components."!minecraft:charged_projectiles" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:enchantment_glint_override" set from storage iota_broken:scratch item.components."minecraft:enchantment_glint_override"
execute if data storage iota_broken:scratch item.components."!minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:enchantment_glint_override" set value {}
data remove storage iota_broken:scratch item.components."minecraft:enchantment_glint_override"
data modify storage iota_broken:scratch item.components."!minecraft:enchantment_glint_override" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:minimum_attack_charge" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:minimum_attack_charge" set from storage iota_broken:scratch item.components."minecraft:minimum_attack_charge"
execute if data storage iota_broken:scratch item.components."!minecraft:minimum_attack_charge" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:minimum_attack_charge" set value {}
data remove storage iota_broken:scratch item.components."minecraft:minimum_attack_charge"
data modify storage iota_broken:scratch item.components."!minecraft:minimum_attack_charge" set value {}
execute if data storage iota_broken:scratch item.components."minecraft:tooltip_display" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tooltip_display" set from storage iota_broken:scratch item.components."minecraft:tooltip_display"
execute if data storage iota_broken:scratch item.components."!minecraft:tooltip_display" run data modify storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:tooltip_display" set value {}
data remove storage iota_broken:scratch item.components."minecraft:tooltip_display"
data modify storage iota_broken:scratch item.components."!minecraft:tooltip_display" set value {}
data remove storage iota_broken:scratch item.components."!minecraft:attribute_modifiers"
data modify storage iota_broken:scratch item.components."minecraft:attribute_modifiers" set value [{type:"minecraft:attack_speed",id:"iota:broken_speed",amount:-1024.0d,operation:"add_value",slot:"mainhand"},{type:"minecraft:attack_damage",id:"iota:broken_damage",amount:-1024.0d,operation:"add_value",slot:"mainhand"}]
data remove storage iota_broken:scratch item.components."!minecraft:minimum_attack_charge"
data modify storage iota_broken:scratch item.components."minecraft:minimum_attack_charge" set value 1.0f
data remove storage iota_broken:scratch item.components."!minecraft:tooltip_display"
data modify storage iota_broken:scratch item.components."minecraft:tooltip_display" set value {hidden_components:[]}
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tooltip_display" run data modify storage iota_broken:scratch item.components."minecraft:tooltip_display" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tooltip_display"
execute unless data storage iota_broken:scratch item.components."minecraft:tooltip_display".hidden_components run data modify storage iota_broken:scratch item.components."minecraft:tooltip_display".hidden_components set value []
execute unless data storage iota_broken:scratch item.components."minecraft:tooltip_display"{hidden_components:["minecraft:attribute_modifiers"]} run data modify storage iota_broken:scratch item.components."minecraft:tooltip_display".hidden_components append value "minecraft:attribute_modifiers"
data remove storage iota_broken:scratch item.components."!minecraft:tool"
data modify storage iota_broken:scratch item.components."minecraft:tool" set value {rules:[],default_mining_speed:0.0f,damage_per_block:0}
data remove storage iota_broken:scratch item.components."!minecraft:weapon"
data modify storage iota_broken:scratch item.components."minecraft:weapon" set value {item_damage_per_attack:0}
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:enchantment_glint_override"
scoreboard players set #ench im_broken 0
execute store result score #ench im_broken run data get storage iota_broken:scratch item.components."minecraft:enchantments"
execute if score #ench im_broken matches 0 unless data storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" set value 0b
execute if data storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" run data remove storage iota_broken:scratch item.components."!minecraft:enchantment_glint_override"
execute store result score #max im_broken run data get storage iota_broken:scratch capture.default_max
execute if data storage iota_broken:scratch item.components."minecraft:max_damage" store result score #max im_broken run data get storage iota_broken:scratch item.components."minecraft:max_damage"
scoreboard players remove #max im_broken 1
execute store result storage iota_broken:scratch item.components."minecraft:damage" int 1 run scoreboard players get #max im_broken
summon item ~ ~0.5 ~ {Tags:["iota_broken_buffer"],Invulnerable:1b,NoGravity:1b,PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
data modify entity @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] Owner set from entity @s UUID
data modify entity @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] Item set from storage iota_broken:scratch item
item modify entity @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] contents iota_exp_tool_mastery:broken_equipment/guard
execute store success score #ready im_broken run data get entity @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] Item.components."minecraft:custom_data".iota_broken_equipment
$execute if score #ready im_broken matches 1 if score #live im_broken matches 1 if score #different im_broken matches 0 run item replace entity @s $(slot) with air
data merge entity @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] {PickupDelay:2s}
tag @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] add iota_broken_equipment_drop
tag @e[type=item,tag=iota_broken_buffer,limit=1,sort=nearest,distance=..2] remove iota_broken_buffer
