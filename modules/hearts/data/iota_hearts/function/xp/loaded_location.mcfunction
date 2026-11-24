# Assess unplaced death sites only once the chunk is available.
execute unless data storage iota_hearts:xp work.record{placed:1b} run function iota_hearts:xp/check_site
execute if data storage iota_hearts:xp work.record{relocate:1b} run return run function iota_hearts:xp/relocate
function iota_hearts:xp/spawn_missing
