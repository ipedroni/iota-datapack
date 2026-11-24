scoreboard objectives add ed_eff dummy
scoreboard objectives add ed_found dummy
tellraw @a {"text":"[Magical Discovery] /function iota_exp_magical_discovery:help","color":"aqua"}
scoreboard objectives add id_aqua_affinity dummy
scoreboard objectives add id_bane_of_arthropods dummy
scoreboard objectives add id_blast_protection dummy
scoreboard objectives add id_channeling dummy
scoreboard objectives add id_depth_strider dummy
scoreboard objectives add id_efficiency dummy
scoreboard objectives add id_feather_falling dummy
scoreboard objectives add id_fire_aspect dummy
scoreboard objectives add id_fire_protection dummy
scoreboard objectives add id_flame dummy
scoreboard objectives add id_fortune dummy
scoreboard objectives add id_frost_walker dummy
scoreboard objectives add id_impaling dummy
scoreboard objectives add id_infinity dummy
scoreboard objectives add id_looting dummy
scoreboard objectives add id_loyalty dummy
scoreboard objectives add id_mending dummy
scoreboard objectives add id_multishot dummy
scoreboard objectives add id_piercing dummy
scoreboard objectives add id_power dummy
scoreboard objectives add id_projectile_protection dummy
scoreboard objectives add id_protection dummy
scoreboard objectives add id_punch dummy
scoreboard objectives add id_quick_charge dummy
scoreboard objectives add id_respiration dummy
scoreboard objectives add id_riptide dummy
scoreboard objectives add id_sharpness dummy
scoreboard objectives add id_silk_touch dummy
scoreboard objectives add id_smite dummy
scoreboard objectives add id_soul_speed dummy
scoreboard objectives add id_sweeping_edge dummy
scoreboard objectives add id_swift_sneak dummy
scoreboard objectives add id_thorns dummy
scoreboard objectives add id_unbreaking dummy

scoreboard objectives add id_scan dummy
scoreboard objectives add id_breach dummy
scoreboard objectives add id_density dummy
scoreboard objectives add id_knockback dummy
scoreboard objectives add id_luck_of_the_sea dummy
scoreboard objectives add id_lunge dummy
scoreboard objectives add id_lure dummy
scoreboard objectives add id_wind_burst dummy
execute unless score #world id_efficiency matches 1.. run scoreboard players set #world id_efficiency 1
execute unless score #world id_unbreaking matches 1.. run scoreboard players set #world id_unbreaking 1
execute unless score #world id_sharpness matches 1.. run scoreboard players set #world id_sharpness 1
execute unless score #world id_power matches 1.. run scoreboard players set #world id_power 1
execute unless score #world id_piercing matches 1.. run scoreboard players set #world id_piercing 1
execute unless score #world id_impaling matches 1.. run scoreboard players set #world id_impaling 1
execute unless score #world id_protection matches 1.. run scoreboard players set #world id_protection 1
execute unless score #world id_feather_falling matches 1.. run scoreboard players set #world id_feather_falling 1
