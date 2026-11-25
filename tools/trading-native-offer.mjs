import assert from 'node:assert/strict';

const equipment = /(?:_(?:pickaxe|axe|shovel|hoe|sword|spear|helmet|chestplate|leggings|boots)|:(?:bow|crossbow|shears))$/;
const stack = entry => ({ id: entry.item, count: entry.count,
  ...(entry.components ? { components: entry.components } : {}) });

export function nativeOffer(offer) {
  const [first, second] = offer.inputs;
  const buy = stack(first);
  if (offer.direction === 'buy' && equipment.test(offer.item)) {
    buy.components = { ...buy.components, 'minecraft:damage': 0 };
    if (offer.enchantments.startsWith('optional low-potency Basic')) {
      buy.components['minecraft:map_color'] = 1091330;
    } else {
      assert.equal(offer.enchantments, 'plain');
      buy.components['minecraft:note_block_sound'] = 'iota_trades_qual:plain';
    }
  }
  return { buy, ...(second ? { buyB: stack(second) } : {}), sell: stack(offer.output),
    uses: 0, maxUses: offer.usesPerRefill ?? 1, xp: 0, rewardExp: true, priceMultiplier: 0 };
}
