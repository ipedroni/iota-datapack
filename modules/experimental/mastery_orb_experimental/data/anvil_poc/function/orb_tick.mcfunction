# v3.8.2: migrate existing v3.8/3.8.1 stations once, preserving the item and transfer logic.
execute as @e[type=minecraft:interaction,tag=ap_orb_v38,tag=!ap_orb_v382] at @s run function anvil_poc:orb_migrate_382
execute as @e[type=minecraft:interaction,tag=ap_orb_v382,tag=!ap_orb_v383] at @s run function anvil_poc:orb_migrate_383
execute as @e[type=minecraft:interaction,tag=ap_orb_v383,tag=!ap_orb_v384] at @s run function anvil_poc:orb_migrate_384
execute as @e[type=minecraft:interaction,tag=ap_orb_v384,tag=!ap_orb_v386] at @s run function anvil_poc:orb_migrate_386
execute as @e[type=minecraft:interaction,tag=ap_orb_v386,tag=!ap_orb_v387] at @s run function anvil_poc:orb_migrate_387
# Station lifecycle. New stations use item_display + interaction, no physical head.
execute as @e[type=minecraft:interaction,tag=ap_orb_v38] at @s unless block ~ ~-1 ~ #anvil_poc:anvils run function anvil_poc:orb_destroy_station
# Legacy v3.7 stations: keep support until upgraded by scan.
execute as @e[type=minecraft:interaction,tag=ap_orb_v37,tag=!ap_orb_v38] at @s unless block ~ ~ ~ minecraft:player_head run kill @s
execute as @e[type=minecraft:interaction,tag=ap_orb_v37,tag=!ap_orb_v38] at @s unless block ~ ~-1 ~ #anvil_poc:anvils run kill @s
execute as @e[type=minecraft:interaction,tag=ap_orb,tag=!ap_orb_v37,tag=!ap_orb_v38] at @s unless block ~ ~-1 ~ minecraft:player_head run kill @s
execute as @e[type=minecraft:interaction,tag=ap_orb,tag=!ap_orb_v37,tag=!ap_orb_v38] at @s unless block ~ ~-2 ~ #anvil_poc:anvils run kill @s
# Read attacks before right-clicks; attack on interaction entities is recorded separately.
execute as @e[type=minecraft:interaction,tag=ap_orb_v38,nbt={attack:{}}] at @s run function anvil_poc:orb_attack_dispatch
# Read clicks before clearing their interaction data.
execute as @e[type=minecraft:interaction,tag=ap_orb,nbt={interaction:{}}] at @s run function anvil_poc:orb_dispatch
# Very light aura, once every 10 ticks, near loaded/active stations.
scoreboard players add #aura ap_orb_ray 1
execute if score #aura ap_orb_ray matches 10.. run function anvil_poc:orb_aura
execute if score #aura ap_orb_ray matches 10.. run scoreboard players set #aura ap_orb_ray 0

# Restore the identity of decorative Mastery Orb drops (matched by the unique head texture).
execute as @e[type=minecraft:item,tag=!ap_orb_named,nbt={Item:{id:"minecraft:player_head"}}] at @s run function anvil_poc:orb_restore_item_386
