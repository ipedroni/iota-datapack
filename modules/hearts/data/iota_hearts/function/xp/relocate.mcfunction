data modify storage iota_hearts:xp work.record.location set from storage iota_hearts:xp work.record.fallback
data modify storage iota_hearts:xp work.record.relocate set value 0b
data modify storage iota_hearts:xp work.record.placed set value 1b
function iota_hearts:xp/save_record with storage iota_hearts:xp work
function iota_hearts:xp/ensure_location with storage iota_hearts:xp work.record.location
