import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../../../', import.meta.url));
const read = file => fs.readFileSync(path.join(root, file), 'utf8');
import { sales, purchases } from '../../../tools/trading-candidate-quotes.mjs';

const recipes = new Map();
const tags = new Map();
for (const directory of ['vendor/generated/data', 'modules/recipes/data']) {
  for (const relativeFile of fs.readdirSync(path.join(root, directory), { recursive: true })) {
    const match = relativeFile.replaceAll('\\', '/').match(/^([^/]+)\/(recipe|tags\/item)\/(.+)\.json$/);
    if (!match) continue;
    const [, namespace, kind, name] = match;
    const key = namespace + ':' + name;
    const data = JSON.parse(read(directory + '/' + relativeFile));
    if (kind === 'recipe') recipes.set(key, data);
    else tags.set(key, [...(data.replace ? [] : tags.get(key) ?? []), ...data.values]);
  }
}
function expand(ingredient, seen = new Set()) {
  if (Array.isArray(ingredient)) return ingredient.flatMap(value => expand(value, seen));
  if (typeof ingredient === 'object' && ingredient !== null) {
    return expand(ingredient.item ?? (ingredient.tag && '#' + ingredient.tag), seen);
  }
  if (typeof ingredient !== 'string') return [];
  if (!ingredient.startsWith('#')) return [ingredient];
  const key = ingredient.slice(1);
  if (seen.has(key)) return [];
  return (tags.get(key) ?? []).flatMap(entry => expand(typeof entry === 'string' ? entry : entry.id, new Set([...seen, key])));
}
const supported = new Set(['crafting_shaped', 'crafting_shapeless', 'smelting', 'blasting', 'smoking', 'campfire_cooking', 'stonecutting']);
const conversions = [];
for (const [name, recipe] of recipes) {
  if (!supported.has(recipe.type?.split(':').at(-1)) || !recipe.result?.id) continue;
  const raw = recipe.pattern ? [...recipe.pattern.join('').replaceAll(' ', '')].map(symbol => recipe.key[symbol])
    : recipe.ingredients ?? [recipe.ingredient];
  const inputs = raw.map(ingredient => expand(ingredient));
  if (inputs.length && inputs.every(options => options.length)) {
    conversions.push({ name, output: recipe.result.id, count: recipe.result.count ?? 1, inputs });
  }
}
const discount = (count, level) => level ? Math.max(1, count - Math.max(1, Math.floor(count * (.30 + .0625 * (level - 1))))) : count;
const manufacturing = new Map([
  ['minecraft:cooked_cod', 'minecraft:cooked_cod ← minecraft:cod'],
  ['minecraft:cooked_salmon', 'minecraft:cooked_salmon ← minecraft:salmon'],
  ['minecraft:ender_eye', 'minecraft:ender_eye ← minecraft:ender_pearl, minecraft:blaze_powder'],
  ['minecraft:leather_boots', 'minecraft:leather_boots ← minecraft:leather'],
]);
const findings = [];
const coverage = [];
for (let level = 0; level <= 5; level++) {
  const best = new Map();
  function offer(item, cost, source) {
    if (cost >= (best.get(item)?.cost ?? Infinity) - 1e-10) return false;
    best.set(item, { cost, source });
    return true;
  }
  for (const { item, lot, emeralds, blocks } of sales) offer(item, (discount(emeralds, level) + 9 * blocks) / lot, item);
  let passes = 0;
  let changed = true;
  while (changed) {
    if (++passes > 100) throw new Error('Conversion values did not stabilize');
    changed = false;
    for (const { name, output, count, inputs } of conversions) {
      const available = inputs.map(options => options.reduce((cheapest, option) => {
        const current = best.get(option);
        return current && current.cost < (cheapest?.cost ?? Infinity) ? current : cheapest;
      }, undefined));
      if (available.some(input => !input)) continue;
      const cost = available.reduce((sum, input) => sum + input.cost, 0) / count;
      const source = name + ' ← ' + [...new Set(available.map(input => input.source))].join(', ');
      if (offer(output, cost, source)) changed = true;
    }
  }
  const reachable = purchases.filter(quote => best.has(quote.item));
  coverage.push({ hero: level, distinctPurchaseItems: new Set(reachable.map(quote => quote.item)).size, passes });
  for (const { item, lot, payout } of reachable) {
    const { cost, source } = best.get(item);
    const bid = payout / discount(lot, level);
    if (bid >= cost - 1e-10) findings.push({ hero: level, item, cost, bid, source, manufacturing: manufacturing.get(item) === source });
  }
}
const unexpected = findings.filter(finding => !finding.manufacturing);
console.log(JSON.stringify({ recipes: conversions.length, tags: tags.size, coverage, manufacturing: findings.filter(finding => finding.manufacturing), unexpected }, null, 2));
if (unexpected.length) process.exitCode = 1;
