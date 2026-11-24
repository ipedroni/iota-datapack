execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:protection" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:blast_protection" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:projectile_protection" run return 0
$return run function iota_exp_tool_mastery:reward/eligible {enchant:"$(enchant)",min:$(min),max:$(max),weight:$(weight),pool:"$(pool)"}
