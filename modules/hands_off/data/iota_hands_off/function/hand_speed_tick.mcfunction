# Apply penalty only for empty/unrecognized main-hand items, without a status effect.
scoreboard players set @s primitive_hand_target 0
execute unless score @s primitive_fatigue matches 0 unless items entity @s weapon.mainhand #iota_hands_off:mining_tools unless items entity @s weapon.mainhand #iota_hands_off:fatigue_exempt run scoreboard players set @s primitive_hand_target 1
execute unless score @s primitive_hand_target = @s primitive_hand_state run function iota_hands_off:hand_speed_transition
