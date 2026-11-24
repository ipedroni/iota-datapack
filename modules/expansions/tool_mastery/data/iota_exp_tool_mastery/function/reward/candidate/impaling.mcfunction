execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:sharpness" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:smite" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:bane_of_arthropods" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:density" run return 0
execute if data storage iota_tool_mastery:progress stack.components."minecraft:enchantments"."minecraft:breach" run return 0
$return run function iota_exp_tool_mastery:reward/eligible {enchant:"$(enchant)",min:$(min),max:$(max),weight:$(weight),pool:"$(pool)"}
