summon item ~ ~0.5 ~ {Tags:["iota_broken_restore"],Invulnerable:1b,NoGravity:1b,PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
$item replace entity @e[type=item,tag=iota_broken_restore,limit=1,sort=nearest,distance=..2] contents from entity @s $(slot)
data modify storage iota_broken:scratch item set from entity @e[type=item,tag=iota_broken_restore,limit=1,sort=nearest,distance=..2] Item
data remove storage iota_broken:scratch item.components."minecraft:equippable"
data remove storage iota_broken:scratch item.components."!minecraft:equippable"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:equippable" run data modify storage iota_broken:scratch item.components."minecraft:equippable" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:equippable"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:equippable" run data modify storage iota_broken:scratch item.components."!minecraft:equippable" set value {}
data remove storage iota_broken:scratch item.components."minecraft:attribute_modifiers"
data remove storage iota_broken:scratch item.components."!minecraft:attribute_modifiers"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:attribute_modifiers" run data modify storage iota_broken:scratch item.components."minecraft:attribute_modifiers" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:attribute_modifiers"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:attribute_modifiers" run data modify storage iota_broken:scratch item.components."!minecraft:attribute_modifiers" set value {}
data remove storage iota_broken:scratch item.components."minecraft:tool"
data remove storage iota_broken:scratch item.components."!minecraft:tool"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tool" run data modify storage iota_broken:scratch item.components."minecraft:tool" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tool"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:tool" run data modify storage iota_broken:scratch item.components."!minecraft:tool" set value {}
data remove storage iota_broken:scratch item.components."minecraft:weapon"
data remove storage iota_broken:scratch item.components."!minecraft:weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:weapon" run data modify storage iota_broken:scratch item.components."minecraft:weapon" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:weapon" run data modify storage iota_broken:scratch item.components."!minecraft:weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:kinetic_weapon"
data remove storage iota_broken:scratch item.components."!minecraft:kinetic_weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:kinetic_weapon" run data modify storage iota_broken:scratch item.components."minecraft:kinetic_weapon" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:kinetic_weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:kinetic_weapon" run data modify storage iota_broken:scratch item.components."!minecraft:kinetic_weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:piercing_weapon"
data remove storage iota_broken:scratch item.components."!minecraft:piercing_weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:piercing_weapon" run data modify storage iota_broken:scratch item.components."minecraft:piercing_weapon" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:piercing_weapon"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:piercing_weapon" run data modify storage iota_broken:scratch item.components."!minecraft:piercing_weapon" set value {}
data remove storage iota_broken:scratch item.components."minecraft:blocks_attacks"
data remove storage iota_broken:scratch item.components."!minecraft:blocks_attacks"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:blocks_attacks" run data modify storage iota_broken:scratch item.components."minecraft:blocks_attacks" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:blocks_attacks"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:blocks_attacks" run data modify storage iota_broken:scratch item.components."!minecraft:blocks_attacks" set value {}
data remove storage iota_broken:scratch item.components."minecraft:glider"
data remove storage iota_broken:scratch item.components."!minecraft:glider"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:glider" run data modify storage iota_broken:scratch item.components."minecraft:glider" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:glider"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:glider" run data modify storage iota_broken:scratch item.components."!minecraft:glider" set value {}
data remove storage iota_broken:scratch item.components."minecraft:charged_projectiles"
data remove storage iota_broken:scratch item.components."!minecraft:charged_projectiles"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:charged_projectiles" run data modify storage iota_broken:scratch item.components."minecraft:charged_projectiles" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:charged_projectiles"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:charged_projectiles" run data modify storage iota_broken:scratch item.components."!minecraft:charged_projectiles" set value {}
data remove storage iota_broken:scratch item.components."minecraft:enchantment_glint_override"
data remove storage iota_broken:scratch item.components."!minecraft:enchantment_glint_override"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."minecraft:enchantment_glint_override" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:enchantment_glint_override"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:enchantment_glint_override" run data modify storage iota_broken:scratch item.components."!minecraft:enchantment_glint_override" set value {}
data remove storage iota_broken:scratch item.components."minecraft:minimum_attack_charge"
data remove storage iota_broken:scratch item.components."!minecraft:minimum_attack_charge"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:minimum_attack_charge" run data modify storage iota_broken:scratch item.components."minecraft:minimum_attack_charge" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:minimum_attack_charge"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:minimum_attack_charge" run data modify storage iota_broken:scratch item.components."!minecraft:minimum_attack_charge" set value {}
data remove storage iota_broken:scratch item.components."minecraft:tooltip_display"
data remove storage iota_broken:scratch item.components."!minecraft:tooltip_display"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tooltip_display" run data modify storage iota_broken:scratch item.components."minecraft:tooltip_display" set from storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."minecraft:tooltip_display"
execute if data storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.saved."!minecraft:tooltip_display" run data modify storage iota_broken:scratch item.components."!minecraft:tooltip_display" set value {}
data remove storage iota_broken:scratch item.components."minecraft:enchantments"."iota_exp_tool_mastery:broken_equipment/guard"
execute store result score #had_data im_broken run data get storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.had_data
execute store result score #had_ench im_broken run data get storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment.had_ench
execute store result score #ench im_broken run data get storage iota_broken:scratch item.components."minecraft:enchantments"
execute if score #had_ench im_broken matches 0 if score #ench im_broken matches 0 run data remove storage iota_broken:scratch item.components."minecraft:enchantments"
data remove storage iota_broken:scratch item.components."minecraft:custom_data".iota_broken_equipment
execute store result score #size im_broken run data get storage iota_broken:scratch item.components."minecraft:custom_data"
execute if score #had_data im_broken matches 0 if score #size im_broken matches 0 run data remove storage iota_broken:scratch item.components."minecraft:custom_data"
data modify entity @e[type=item,tag=iota_broken_restore,limit=1,sort=nearest,distance=..2] Item set from storage iota_broken:scratch item
$item replace entity @s $(slot) from entity @e[type=item,tag=iota_broken_restore,limit=1,sort=nearest,distance=..2] contents
kill @e[type=item,tag=iota_broken_restore,distance=..2]
