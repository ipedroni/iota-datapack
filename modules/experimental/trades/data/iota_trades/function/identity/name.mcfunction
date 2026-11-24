execute store result score #name it_identity_tmp run random value 0..15
execute if score #name it_identity_tmp matches 0 run data merge entity @s {"CustomName": {"text": "Alden", "italic": false}}
execute if score #name it_identity_tmp matches 1 run data merge entity @s {"CustomName": {"text": "Briar", "italic": false}}
execute if score #name it_identity_tmp matches 2 run data merge entity @s {"CustomName": {"text": "Cora", "italic": false}}
execute if score #name it_identity_tmp matches 3 run data merge entity @s {"CustomName": {"text": "Dorian", "italic": false}}
execute if score #name it_identity_tmp matches 4 run data merge entity @s {"CustomName": {"text": "Ellis", "italic": false}}
execute if score #name it_identity_tmp matches 5 run data merge entity @s {"CustomName": {"text": "Fern", "italic": false}}
execute if score #name it_identity_tmp matches 6 run data merge entity @s {"CustomName": {"text": "Galen", "italic": false}}
execute if score #name it_identity_tmp matches 7 run data merge entity @s {"CustomName": {"text": "Hazel", "italic": false}}
execute if score #name it_identity_tmp matches 8 run data merge entity @s {"CustomName": {"text": "Idris", "italic": false}}
execute if score #name it_identity_tmp matches 9 run data merge entity @s {"CustomName": {"text": "Juniper", "italic": false}}
execute if score #name it_identity_tmp matches 10 run data merge entity @s {"CustomName": {"text": "Kellan", "italic": false}}
execute if score #name it_identity_tmp matches 11 run data merge entity @s {"CustomName": {"text": "Laurel", "italic": false}}
execute if score #name it_identity_tmp matches 12 run data merge entity @s {"CustomName": {"text": "Morgan", "italic": false}}
execute if score #name it_identity_tmp matches 13 run data merge entity @s {"CustomName": {"text": "Rowan", "italic": false}}
execute if score #name it_identity_tmp matches 14 run data merge entity @s {"CustomName": {"text": "Sage", "italic": false}}
execute if score #name it_identity_tmp matches 15 run data merge entity @s {"CustomName": {"text": "Wren", "italic": false}}
