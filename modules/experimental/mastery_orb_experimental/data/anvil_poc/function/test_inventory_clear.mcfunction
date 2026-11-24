clear @s minecraft:paper[minecraft:custom_data~{anvil_poc:{inventory_filler:1b}}]
tellraw @s {"text":"[ORBE TEST] Tagged filler items removed. Other items preserved.","color":"green"}
function anvil_poc:test_inventory_status
