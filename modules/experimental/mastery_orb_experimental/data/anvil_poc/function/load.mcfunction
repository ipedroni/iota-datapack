scoreboard objectives add ap_primary dummy
scoreboard objectives add ap_secondary dummy
scoreboard objectives add ap_result dummy
scoreboard objectives add ap_transfer dummy
scoreboard objectives add ap_verify dummy
scoreboard objectives add ap_readok dummy
scoreboard objectives add ap_orb_ray dummy
scoreboard objectives add ap_orb_found dummy
scoreboard objectives add ap_invempty dummy
tellraw @a {"text":"[Orbe POC] /function anvil_poc:orb_help | /function anvil_poc:test_safety_help","color":"aqua"}
