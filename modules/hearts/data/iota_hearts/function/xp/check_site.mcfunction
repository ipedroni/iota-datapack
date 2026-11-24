data modify storage iota_hearts:xp work.record.relocate set value 0b
execute unless block ~ ~ ~ #iota_hearts:orb_air run data modify storage iota_hearts:xp work.record.relocate set value 1b
execute unless block ~ ~1 ~ #iota_hearts:orb_air run data modify storage iota_hearts:xp work.record.relocate set value 1b
execute if block ~ ~-1 ~ #iota_hearts:orb_unsafe_support run data modify storage iota_hearts:xp work.record.relocate set value 1b
