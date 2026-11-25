# Iota — Future Directions

Canonical backlog of future proposals, deferred directions and unresolved design
questions. Current shipped behavior belongs to [Design Directions](design_directions.md);
the active Toolsmith template and Trading decisions belong to
[Trading Design Directions](discovery/drafts/trading_design_directions.md).

An entry’s state is independent of its design tags. A recorded proposal is not
implementation approval. Progression, Economy, Exploration, Quality and Survival are approved tags. Survival covers health, death, recovery and rest. No existing module is merged or unpaused by this file.




## Group order

Groups are arranged by **qualitative thematic proximity**, not implementation
priority or a computed similarity score. Neighboring groups share the bridge
described below; cross-references handle ideas that span several groups.

| Group | Similarity bridge to the next group |
|---|---|
| 1. Merchant identity, relationships and trust | Personal knowledge and reputation lead into the development of the surrounding community. |
| 2. Village development, market capacity and regional networks | Village capacity and connections lead into what merchants can offer and fulfill. |
| 3. Offer availability, supplies and services | Personalized offers and commissions connect naturally to supplying knowledge and enchantments. |
| 4. Enchanting knowledge, access and application | Enchantments and their costs lead into long-lived equipment and maintenance choices. |
| 5. Equipment progression and maintenance | Equipment changes lead into the risks players and companions face. |
| 6. Survival, companion protection and recovery | Recovery and survival tools connect to crafting, workstations and materials. |
| 7. Crafting stations, material recovery and convenience | Construction/resource routes connect to world materials, structures and loot sources. |
| 8. World exploration, loot and discovery | World discoveries feed the progression journey that player guidance eventually teaches. |
| 9. Learning and progression guidance | A cross-cutting closing group: guidance explains the completed systems above. |




## 1. Merchant identity, relationships and trust


### F-001 — Merchant specialization through found items and teaching

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression, Exploration.

Found items or bundles can personalize one merchant, with teaching a Librarian a found enchantment as one example across professions. Desired offers should be earned and transportable, not an effortless ideal-shop editor.

Eligible items, costs, preservation/consumption, exact resulting offers and limits remain open. Do not implement Librarian teaching alone as a special exception without reviewing the profession-wide pattern.


### F-002 — Taking original village-chest items lowers local reputation

**State:** Future proposal. **Owner:** Village/Trades implementation undecided.

**Design tags:** Progression, Exploration.

Taking items from original world-generated village chests could reduce that player’s reputation with that village. Player-placed storage is not automatically included.

Village identity, ownership/origin tracking, attribution, automation, multiplayer, penalties and recovery need definition and a feasibility prototype. No universal settlement reputation counter is assumed.




## 2. Village development, market capacity and regional networks


### F-003 — Population-based village prosperity and stock

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

A village of about four residents would be poor and trade little; a city of 50+ residents could repeatedly trade the same goods without running out of stock.

Population radius/eligibility, thresholds and stock versus replenishment remain open. Evaluate the incentive to breed/confine villagers; this proposal has not overridden the current anti-prison goal or approved unlimited stock.


### F-004 — Capacity grows through relationships and useful infrastructure

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

Commercial history and useful village facilities could increase capacity. Compare this with population-only growth instead of assuming that entity count is the sole investment.

Relevant facilities, maintenance, progression and caps are undefined. Avoid opaque upkeep and compulsory village development for unrelated playstyles.


### D-005 — Shared demand across buyers and metal-derived goods

**State:** Not selected; shared demand rejected. **Owner:** Trades (proposed).

**Design tags:** Economy.

Historical simulation D explored shared demand. See the [current stock design](discovery/drafts/trading_design_directions.md#working-price-and-stock-calibration).


### F-005 — Regional offer pools and profitable imports

**State:** Framework approved; candidate pools and regional rules drafted. Runtime validation and price review remain open. **Owner:** Trades (proposed).

**Design tags:** Economy, Exploration.

See the [approved regional framework and candidate calibration](discovery/drafts/trading_design_directions.md#regional-economy).


## 3. Offer availability, supplies and services

### F-034 — Most ordinary villager sales available at Novice

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

Make most ordinary sales available as soon as a villager becomes a Novice. As the villager advances, update its purchase offers at each level and add new sales at Expert and Master.

Use level requirements for sales that could let players skip substantial progression early with a small emerald budget. Review each profession's catalog to decide which sales need those requirements and which belong in the initial assortment.


### F-035 — Smithing Template trades and duplication

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression, Exploration.

Consider two offers for Armorer, Toolsmith and Weaponsmith. A direct sale would let players buy their first Netherite Upgrade Smithing Template from a villager. Review how that access affects the incentive to explore Bastion Remnants and the progression from Diamond to Netherite before deciding on a level, price or stock.

A duplication service could be offered at Master. The player supplies one Netherite Upgrade Smithing Template and a payment, and receives two copies of that template. Calibrate the payment against the crafting recipe and review the terms across the three professions. This service requires the player to obtain a template first.

Also consider direct sales of a limited selection of Armor Trim Smithing Templates by the Armorer at Master. Sentry, Dune and Coast are initial candidates. Decide which patterns should remain exclusive to their exploration sources before setting prices or stock.


### F-006 — Periodic offer redraw at interval X

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy.

Redraw villager trades after a time interval X. Decide whether this affects all offers, variable slots, unlocked levels, purchases, sales or special offers.

This revisits, but does not yet replace, the selected persistent career/offer plan. Separate offer replacement from restocking and preserve safe GUI/state handling. Exploration is only a possible outcome; waiting in place might be encouraged instead.


### F-032 — Refresh equipment enchantments when merchants restock

**State:** Future proposal; not approved for implementation. **Priority:** None assigned. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

Explore rolling new enchantments on equipment sold by a villager when its stock replenishes. This could let an established merchant offer different equipment combinations over time.

Decide whether to retain the item family and material, which career levels participate, how prices follow the new enchantments, and whether a refresh requires selling out or an actual restock. Preserve career restrictions, compatibility, enchantment quantity and potency ranges. Review repeated sleep/restock attempts and safe handling of open trading interfaces.

Related to F-006 (periodic offer redraw), but narrower: this proposal concerns enchantments on equipment sales at restock, not automatically replacing the entire catalog, purchases or profession. See the [current restock design](discovery/drafts/trading_design_directions.md#working-price-and-stock-calibration).


### F-007 — Early everyday-supplies purchase pool

**State:** Deferred discussion. **Owner:** Trades (proposed).

**Design tags:** Economy.

After the Toolsmith template is closed, evaluate an additional early player-to-villager sale of useful supplies such as Sticks, String, Flint or food.

Decide profession-specific pools, slot count, level, uniqueness, quantities and stock. Respect Fisherman not buying fish and Toolsmith not selling Flint. No extra offer is selected now.


### F-008 — Seed exchange with Farmers

**State:** Requested future direction. **Owner:** Trades (proposed).

**Design tags:** Economy.

Explore Farmer seed trading. Types, direction, progression, prices and stock remain open.

Compare Wheat-to-Seeds and vegetation drops; do not automatically put rare exploration seeds in a generic pool.


### F-009 — Commissions for manufactured supplies

**State:** Future proposal. **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

A player might place a written request near a Mason, for example to manufacture Stone Bricks, and the merchant could accept it later.

Ownership, payment, acceptance, production, delivery and cancellation require a separate prototype after basic catalogs.

## 4. Enchanting knowledge, access and application


### F-010 — Native-table discovery unlocks and level gating

**State:** Selected direction; frozen/unimplemented. **Owner:** Magical Discovery.

**Design tags:** Progression, Exploration.

The intended table starts with the approved basic level-I pool, then shares discovered enchantments/levels across the world. Higher levels unlock lower ones; discovered Treasure may enter the intended pool, curses do not.

The shared register and automatic preserved-item discovery already exist. Native offer filtering, level caps and refresh behavior do not; consult frozen Expansion Status before assuming feasibility.


### F-011 — Books on shelves influence enchanting choices

**State:** Future proposal. **Owner:** Enchanting owner undecided.

**Design tags:** Progression, Exploration.

Study using books stored in shelves to influence enchanting availability, related to discovery and found knowledge.

Exact shelf/container scope, ownership, book preservation, native UI limits and progression are undefined; do not silently replace the shared-register design.


### F-012 — Enchant already-enchanted equipment through the table

**State:** Feasibility question. **Owner:** Enchanting owner undecided.

**Design tags:** Progression.

Investigate adding enchantments to already-enchanted equipment through the Enchanting Table.

No native-UI solution is established. Compatibility, costs, identity and whether an alternative interaction is acceptable remain open.


### F-013 — Enchanted gems as deliberate application catalysts

**State:** Future proposal. **Owner:** Recipes/enchanting owner undecided.

**Design tags:** Progression, Economy, Exploration.

Study combining an enchanted book with a Diamond to create an enchanted gem, then applying it through an anvil, Smithing Table or another appropriate mechanism.

Thematic coherence and the cost of hand-picked enchantments are the goals. Book/gem consumption, multi-enchantment contents, levels, compatibility and workstation behavior need definition; native anvils are not assumed to accept gems as book substitutes.


### F-014 — Fixed recipes for selected enchanted books

**State:** Future proposal. **Owner:** Recipes/enchanting owner undecided.

**Design tags:** Progression, Economy.

Study fixed crafting recipes for some enchanted books.

Books, levels, ingredients and the effect on exploration/discovery remain open. This is not approval to craft every book or bypass Treasure acquisition.


### F-028 — Broader enchantment pools for artisan equipment

**State:** Requested follow-up after the document review (task D05). **Owner:** Trades (proposed).

**Design tags:** Economy, Progression.

Review the enchantments on equipment traded by artisans. Use broader, appropriate enchantment pools instead of restricting the design to the current named choices such as Efficiency, Unbreaking and Fortune. Review retail equipment and player-supplied equipment together; do not silently narrow the request to one trade direction.

First agree on a shared situational, basic, advanced and treasure classification for artisan trades and Magical Discovery. Then review compatibility, material and career tiers, access and prices. This request schedules the design review; it does not approve every enchantment or change the current catalog.

E06 is complete. See the [shared classification](design_directions.md#shared-enchantment-classification) and the [artisan review](discovery/drafts/trading_design_directions.md#artisan-equipment-enchantments). Applying the categories to Magical Discovery, mastery rewards and vanilla acquisition still needs review.


### F-031 — Extend enchantment classification to optional mods

**State:** Future proposal; mod selection pending. **Priority:** None assigned. **Owner:** Shared enchantment design; implementation undecided.

**Design tags:** Progression, Exploration, Economy.

After reviewing vanilla enchantments, consider classifying enchantments supplied by mods suggested by the user. Examples include Veinmining, which can mine connected ores, and Treefelling or variants of Veinmining that can harvest a tree's logs. Exact behavior depends on the selected mod and must be checked before classification.

For Iota's design, Treasure can include enchantments that substantially change the gameplay loop, beyond the vanilla Treasure category. Evaluate changes to resource gathering, repeated work and equipment maintenance, rather than treating raw power or a high enchantment level alone as sufficient.

Keep Iota's design category separate from Minecraft's technical Treasure tags. The shared classification will inform the Trading redesign, so some acquisition routes will change through merchant offers. Exact offers, levels, prices and availability remain subject to that review. Separately, study whether and how Iota Treasure should affect vanilla distribution, including enchanting-table access, loot, fishing and technical enchantment tags. Do not assume these routes stay unchanged or that changing a tag is sufficient. Effects on mastery reward probabilities and discovery rules also need explicit review.

The current review covers vanilla enchantments only. No mod has been selected, no dependency is added, and no integration is authorized by this entry.


### F-015 — Mending access and the point maintenance becomes optional

**State:** Open design question. **Owner:** Trading/enchanting/Tools.

**Design tags:** Progression, Economy, Exploration.

Decide when and through which routes a player may obtain Mending or otherwise finish routine equipment maintenance.

Evaluate discovered sources, merchant supply, repairs and optional expansions together. No final timing or source distribution is selected.




## 5. Equipment progression and maintenance


### F-016 — Unified equipment-progression expansion

**State:** Future proposal. **Owner:** Optional expansions.

**Design tags:** Progression, Exploration.

Consider merging Tool Mastery and Magical Discovery functionally while retaining clear internal boundaries and optional configuration.

Design tags already coordinate goals without requiring a merger. Both expansions remain separate. See [expansion status](design_directions.md). A merger remains a future proposal.


### F-017 — Lateral equipment progression

**State:** Future proposal. **Owner:** Equipment systems.

**Design tags:** Progression.

Study tool, weapon and armor choices with distinct strengths/trade-offs instead of only vertical replacement.

No equipment stats, branch system or replacement curve is selected.


### F-018 — Review armor outside the six main material sets

**State:** Planned review. **Owner:** Tools/equipment systems.

**Design tags:** Progression.

Review armor outside Leather, Copper, Iron, Gold, Diamond and Netherite, including Chainmail and Turtle Shell.

Evaluate their roles before selecting stat, recipe or progression changes; examples are not a finalized expansion list.


### F-020 — One repair material restores full durability

**State:** Requested direction; feasibility unresolved. **Owner:** Tools/custom repair owner undecided.

**Design tags:** Progression, Economy.

Revisit one Stick, Flint, ingot, Diamond or Netherite Scrap repairing the corresponding equipment fully.

Current native material repair still restores roughly one quarter per unit; repairable chooses the ingredient, not that fraction. A custom interaction would need a prototype. Existing ingredient substitutions are already shipped.


### F-037 — Universal Blocking

**State:** Future proposal; not approved for implementation. **Priority:** None assigned. **Owner:** Equipment systems (proposed).

**Design tags:** Progression, Survival.

Allow held tools, weapons and other equipment (excluding armor) to provide improvised blocking. Equipment type should determine most of the defensive effectiveness, with smaller material-based modifiers. The Shield must remain vastly superior and retain its vanilla role.

Initial calibration candidates (damage blocked / total frontal protection angle): Shield 100% / 180° (vanilla reference); Sword 35% / 120°; Axe and Mace 25% / 100°; Spear and Trident 20% / 90°; Pickaxe and Shovel 15% / 80°; Hoe 10% / 60°; Bow and Crossbow 5% / 60°; Fishing Rod, Shears, Brush and Flint and Steel 5% / 40°. Candidate material multipliers: Wood ×0.80, Stone ×0.85, Gold ×0.90, Copper ×0.95, Iron ×1.00, Diamond ×1.10, Netherite ×1.20. These values are illustrative, not selected balance; review other equipment and material-less items separately.

Consider restricting improvised blocking to melee damage, preserving Shield protection against projectiles and explosions subject to vanilla exceptions. Differentiate activation delay, durability cost and protection angle by equipment type.

Investigate the native `minecraft:blocks_attacks` component in Java 1.21.11 using a datapack-only prototype, without mandatory mods or resource packs. Validate activation and animations, right-click conflicts with native tool actions (including stripping, tilling, shooting, fishing and spear attacks), Shield priority in the offhand, durability and Broken equipment behavior. Preserve existing item functionality; universal coverage is a design goal, not established technical feasibility.

Potential later Tool Mastery integration: XP for successful blocks, reduced blocking durability costs at higher mastery, and a small Masterwork defensive bonus. Keep this separate from the initial blocking prototype. No expansion is merged or unpaused by this proposal.


## 6. Survival, companion protection and recovery

### F-021 — Half-heart damage after a qualifying empty-hand break

**State:** Requested feasibility topic, absent from current code. **Owner:** Hands Off (possible).

**Design tags:** Progression, Survival.

Consider half a heart of damage if and only if wood, stone or ore is successfully broken with an empty main hand.

This is distinct from the canceled selective block-breaking prohibition and from detecting the start of mining. No such damage event is present in current Hands Off; no implementation is added by this audit.

### F-029 — Friendly fire protection for pets and villagers

**State:** Deferred after feasibility research for Minecraft Java 1.21.11. **Related task:** Q02. **Design tags:** Quality, Survival.

Study protection against player-caused damage for pets and villagers. A supported lethal hit must be blocked before health is lost. The approved test scope includes unarmed attacks, sweeping attacks, spears, arrows, tridents, potions, spreading fire and falls caused by a player. TNT is outside scope. For villagers, test damage from any player and use hostile mobs, raids, Creeper explosions and environmental hazards as controls. Measure reputation, trade prices and iron golem reactions separately from health loss.

Vanilla damage signals provide attribution in specific contexts. The research did not demonstrate a general datapack hook that cancels incoming damage before it lands. In particular, a fall or spreading fire may no longer identify the player who caused it. Healing after impact can miss lethal hits. Broad invulnerability would also affect hostile and environmental damage.

The pet matrix includes 13 entity types capable of storing a native owner reference. Trader llamas are outside scope. Skeleton horses, camels and camel husks can be mountable without a player UUID. Foxes store trusted references, and Allays remember the player who handed them an item and already block some damage from that player. Ocelot trust records a boolean. Happy Ghast harnesses and passengers indicate current use. These signals support different eligibility rules.

Before resuming, decide whether pet protection covers the owner, the owner and allies, or any player. Define how pets with trust or no saved player UUID qualify. Prototype prevention before impact, verify indirect damage attribution, and decide how blocked attacks affect villager reputation and prices. See the [archived research summary](discovery/research_index.md#friendly-fire-contra-pets-e-villagers). Recovery and respawn are tracked in [F-033](#f-033--animal-recovery-with-a-placed-orb-and-charm).

### F-036 — Call distant pets

**State:** Deferred. **Related task:** Q03. **Design tags:** Quality, Survival.

Let players call a distant pet so it arrives naturally at a safe spot nearby. Define the trigger, selection when several pets are eligible, distance limits and safe arrival rules. Check whether the call can reach a pet in an unloaded area and preserve the identity of the original animal.


### F-033 — Animal recovery with a placed orb and charm

**State:** Deferred. **Owner:** Quality. **Design tags:** Quality, Survival.

Craft and place an orb inspired by the Magical Orb. Use a separate Animal Charm (working name) on an eligible animal, then use that charm on the placed orb to associate the animal with that spawn destination. The orb is the destination for the new design. The earlier bed interaction, hitbox and owner-bed fallback belong to the archived experiment.

Start feasibility work with tamed cats, wolves and parrots, including previously tamed animals. Validate ownership and the orb at the point of binding. Store the animal UUID and the orb's identity and location. When recovering a live animal, find and move the original, loading its last known chunk temporarily if needed. After confirmed death or removal, assess whether to restore the saved animal at the same destination without creating duplicates. A failed UUID lookup leaves the animal's status unknown.

Before resuming, decide recipes, charm consumption or reuse, how many animals an orb can serve, what happens if the orb is moved or broken, and how manual calls and automatic recovery are triggered. Revisit the earlier distance threshold and seated or leashed behavior in that design. See the [archived recovery research](discovery/research_index.md#recuperação-de-animais).

## 7. Crafting stations, material recovery and convenience


### F-022 — Revisit previously discussed cheaper basic recipes

**State:** Earlier discussion; reconfirm scope. **Owner:** Recipes.

**Design tags:** Economy, Quality.

The reference pack suggested cheaper Glass Bottles, ladders, TNT, chains and an item called an electric inverter. The Logs-to-Chests recipe is already implemented.

Those additional basic-recipe overrides were not found in current source and are not treated as selected. Identify any ambiguous item terminology. The selected automation components still produce one per craft; do not silently revive higher yields.


### F-023 — Additional metal/glass Stonecutter families

**State:** Earlier discussion; scope unresolved. **Owner:** Recipes.

**Design tags:** Economy.

Study any desired metal/glass cutting families beyond the current vanilla routes and added wooden routes.

The external reference pack’s 348 recipes are not an automatically approved Iota target. The completed stair/slab/wall/reclaiming decisions remain current behavior.


### F-027 — Reclaiming other compressed materials

**State:** Earlier discussion; reconfirm scope. **Owner:** Recipes.

**Design tags:** Economy.

The reference proposal also mentioned undoing Bamboo, Melon and Amethyst compression. Ice and the selected slab/stair/wall recoveries are already implemented.

No blanket inverse recipe is assumed selected for every compressed block. Audit actual yields and world-breaking conversions, then confirm any additional desired routes before implementation.




## 8. World exploration, loot and discovery


### F-024 — Datapack-wide equipment, treasure and book loot review

**State:** Selected next broad design review. **Owner:** Drops plus related systems.

**Design tags:** Progression, Exploration, Economy.

Review equipment tiers, enchantment levels, rarity and progression roles across loot tables, alongside crafting, Trading, maintenance and optional expansions.

No equipment/treasure/book removals or rates are selected. The separately staged metal drops do not complete this review.


### F-025 — Custom world-generation structures

**State:** Future proposal. **Owner:** World or future world-content owner.

**Design tags:** Exploration.

Consider adding custom structures to world generation.

Designs, placement, frequency, rewards and compatibility remain open.


### F-030 — Physical waypoint markers and discovery

**State:** Tentative future proposal; not approved for implementation. **Priority:** None assigned. **Owner:** Undecided.

**Design tags:** Exploration, Progression, Quality.

Explore physical navigation markers: craft a special, reusable Player Head, name it and place it in the world. The intended waypoint uses the head's name and appears in Xaero's Minimap and World Map only for players who have discovered that marker. The player who places it would know it immediately; other players would discover it by visiting. Discovery would persist between sessions.

The proposed approach uses only a Java 1.21.11 datapack alongside the existing Xaero mods, with no new helper mod or Java project. Compatibility with Iota's plug-and-play goal and optional-module packaging remains to be discussed.


#### Candidate interactions

- Give the marker a unique internal identity, separate from its name and texture, without affecting ordinary Player Heads.
- Rename it in an anvil before placement; use that exact name for the waypoint.
- Potentially rename a placed marker with a named Name Tag, consuming the tag and updating the existing waypoint for its discoverers.
- Potentially combine the marker with a named Name Tag in crafting, consuming the tag and transferring its name while preserving marker data.
- Preserve the latest name and special identity when recovering and reusing the head. Avoid duplicated items or waypoints.
- Track markers by identity, position and dimension, and discoveries by persistent player identity rather than display name. Avoid sending undiscovered coordinates where technically possible.


#### Open design choices

A medium-cost recipe using a Compass, Redstone and common materials was suggested. The example uses four Iron Ingots and four Redstone around a Compass; its ingredients and yield are tentative. Automatic discovery within eight blocks, in three dimensions and without line of sight, is also only a suggestion.

When a marker is destroyed, decide whether to remove its waypoint, retain it as historical knowledge or deactivate it. Recovery and replacement, explosions, unloaded chunks, different dimensions, identical names and changes while discoverers are offline all need rules.


#### Feasibility to investigate later

Automatic integration with Xaero is unproven. A waypoint-sharing chat message is a possible experiment, not evidence that a datapack can create, rename or remove client waypoints. Requiring a click to import a waypoint would differ from the intended automatic experience and needs a separate decision.

Dynamic name transfer during crafting, interaction with a placed head, placement detection, data-preserving drops and efficient discovery tracking also need validation. If this proposal is prioritized later, first test communication with Xaero using one fixed marker; then test the special head, naming methods, discovery and synchronization separately. Do not start these prototypes now.


#### Origin and decision history

Recorded on 2026-11-21 from the user's attached ChatGPT notes, “Iotapack — Waypoint Markers”. Although the source calls some mechanics approved, the user's current instruction treats the entire proposal as tentative and without priority. It does not change the active roadmap or authorize implementation.




## 9. Learning and progression guidance


### F-026 — Player-facing advancement/technology tree

**State:** Selected, deferred until journey settles. **Owner:** Cross-module guidance.

**Design tags:** Progression, Exploration.

Create an advancement tree teaching the finished progression, primitive tools, recipes, mastery, repairs and discovery.

Build it after the overall journey is ready to avoid repeated replacement. Existing hidden technical/recipe-unlock advancements are not this future player-facing tree.




## Boundaries and active research

Active Toolsmith offer details, exact prices/stock, the shop-margin direction and
career implementation remain in the Trading design document rather than being
duplicated here. The economic matrix, farm benchmark and first completed
200,000-journey simulation are research evidence, not selected market mechanics.
See [the archived farm and simulation research](discovery/research_index.md#medições-de-farm-e-simulações-arquivadas).

Completed Hearts recovery/XP-orb features, existing shield rewards, current
recipes and archived Orb station code are not reintroduced as future work.
This backlog preserves the distinction between already implemented prototypes
and proposals to extend them.
