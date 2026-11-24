import json

from math import atan2, ceil, cos, hypot, pi, sin, sqrt

from itertools import groupby

from pathlib import Path

from random import Random

from zipfile import ZIP_DEFLATED, ZipFile



VERSION = '0.13.1'

MINECRAFT_VERSION = '1.21.11'

NAMESPACE = 'capital_cities'

DIMENSION = f'{NAMESPACE}:settlement_400'

OBJECTIVE = 'cc_400'

SIZE = 400

TILE = 80

SURFACE = 80

SPAWN = '200.5 81 335.5'

files = {}





def function(name, commands):

    files[f'data/{NAMESPACE}/function/{name}.mcfunction'] = '\n'.join(commands) + '\n'





def metadata(path, value):

    files[path] = json.dumps(value, ensure_ascii=False, indent=2) + '\n'





def call(name):

    return f'function {NAMESPACE}:{name}'





def fill(x1, y1, z1, x2, y2, z2, material):

    assert (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1) <= 32768

    return f'fill {x1} {y1} {z1} {x2} {y2} {z2} minecraft:{material}'





metadata('pack.mcmeta', {'pack': {

    'description': f'Capital Cities {VERSION} - Minecraft Java {MINECRAFT_VERSION}',

    'min_format': [94, 1],

    'max_format': [94, 1],

}})

metadata(f'data/{NAMESPACE}/dimension/settlement_400.json', {

    'type': 'minecraft:overworld',

    'generator': {'type': 'minecraft:flat', 'settings': {

        'biome': 'minecraft:plains',

        'layers': [

            {'height': 1, 'block': 'minecraft:bedrock'},

            {'height': 141, 'block': 'minecraft:stone'},

            {'height': 2, 'block': 'minecraft:dirt'},

            {'height': 1, 'block': 'minecraft:grass_block'},

        ],

        'lakes': False,

        'features': False,

        'structure_overrides': [],

    }},

})

for event in ('load', 'tick'):

    metadata(f'data/minecraft/tags/function/{event}.json', {'values': [f'{NAMESPACE}:{event}']})



CENTER = SIZE // 2
LAYOUTS = 4
MAX_Y = 124
MOAT_WIDTH = 16
MOAT_BOTTOM = 70
MOAT_START = 14
FORT_LEVEL = SURFACE + 4
CASTLE_LEVEL = FORT_LEVEL + 5
BANK_WIDTH = 3
WALL_HALF_WIDTH = 3.55
WALK_HALF_WIDTH = 2.30
FENCE_CLEARANCE = 5
LOW_WALL_STONE = (
    'stone_bricks', 'mossy_cobblestone', 'cracked_stone_bricks', 'cobblestone',
)
LOW_WALL_DETAILS = ('stone_brick_stairs[half=top]', 'stone_brick_slab')
RETAINING_PALETTE = ('mud_bricks', 'mud_bricks', 'packed_mud', 'terracotta')
MOAT_LOWER = ('mossy_cobblestone', 'mossy_cobblestone', 'moss_block', 'cobblestone', 'stone')
MOAT_UPPER = ('stone', 'cobblestone', 'mossy_cobblestone', 'stone', 'moss_block')
ENTRY_VECTORS = ((0, 1), (1, 0), (0, -1))


FORTIFIED_GROUND = (
    (7, 'grass_block'), (7, 'dirt'), (8, 'coarse_dirt'), (10, 'gravel'),
    (21, 'stone'), (18, 'cobblestone'), (12, 'mossy_cobblestone'),
    (11, 'tuff'), (6, 'deepslate'),
)
OUTER_TOWN_GROUND = (
    (42, 'grass_block'), (39, 'dirt'), (11, 'coarse_dirt'), (3, 'gravel'),
    (2, 'stone'), (2, 'cobblestone'), (1, 'mossy_cobblestone'),
)


def ground_material(x, z, variant, palette):
    # Broad patches mixed with smaller irregular marks.
    patch_x, patch_z = x // 5, z // 5
    patch = (patch_x * 53 ^ patch_z * 131 ^ variant * 499) % 100
    grain = (x * 281 ^ z * 139 ^ variant * 97) % 100
    sample = patch if grain < 76 else grain
    for weight, material in palette:
        if sample < weight:
            return material
        sample -= weight
    raise ValueError('Ground palette must cover the full 0–99 range')


def create_layout(variant):
    regions = []
    origin = variant * 0.78

    def box(x1, z1, x2, z2, y1, y2, material):
        assert 0 <= x1 <= x2 < SIZE and 0 <= z1 <= z2 < SIZE
        assert MOAT_BOTTOM <= y1 <= y2 <= MAX_Y
        regions.append((x1, z1, x2, z2, y1, y2, material))

    def trace(angle):
        return 38 + 4.2*sin(3*angle + origin) + 2.3*sin(7*angle - origin)

    def urban(angle):
        return 85.5 + 4.2*sin(4*angle - origin) + 2*sin(9*angle + origin)

    def rural(angle):
        return 121 + 3.9*sin(5*angle + origin) + 2.8*sin(8*angle - origin)

    def walk_height(angle):
        return 90 + round(1.4*sin(3*angle + origin) + 0.5*sin(6*angle))

    # Measure progress along the curved wall so crenellations keep their rhythm.
    arc_length = [0.0]
    last_x, last_z = -trace(-pi), 0
    for step in range(1, 721):
        angle = -pi + step*pi/360
        x, z = trace(angle)*cos(angle), trace(angle)*sin(angle)
        arc_length.append(arc_length[-1] + hypot(x-last_x, z-last_z))
        last_x, last_z = x, z
    merlon_period = arc_length[-1] / round(arc_length[-1]/5)

    def paint(rows):
        for z in range(SIZE):
            for stack, group in groupby(range(SIZE), key=lambda x: rows.get((x, z), ())):
                xs = list(group)
                for low, high, material in stack:
                    box(xs[0], z, xs[-1], z, low, high, material)

    town_ground = {}
    surfaces = {}
    masonry = {}
    walk_cells = {}
    walk_levels = {}
    verge_candidates = ([], [])
    fence_gaps = tuple(-pi + (i+0.35)*pi/2 + origin*0.19 for i in range(4))
    parapet = {}
    farms = {}
    farm_levels = {}
    for z in range(CENTER-132, CENTER+133):
        for x in range(CENTER-132, CENTER+133):
            dx, dz = x - CENTER, z - CENTER
            angle = atan2(dz, dx)
            radius = hypot(dx, dz)
            citadel, town, border = trace(angle), urban(angle), rural(angle)
            wall_offset = radius - citadel
            noise = (x * 73 ^ z * 97 ^ variant * 41) % 29
            road_distance = min(
                (abs(dx*vz - dz*vx) for vx, vz in ENTRY_VECTORS if dx*vx + dz*vz >= 0),
                default=SIZE,
            )
            road_half_width = 2 if radius < town else 1
            is_road = road_distance <= road_half_width
            in_fence_gap = any(abs(atan2(sin(angle-gap), cos(angle-gap))) < 0.022
                               for gap in fence_gaps)
            fence_half_width = 0.65 if sin(6*angle + origin) < 0 else 1.0
            if abs(radius - border) <= fence_half_width + FENCE_CLEARANCE:
                town_ground[x, z] = ((80, 80, ground_material(x, z, variant, OUTER_TOWN_GROUND)),)
            if wall_offset <= WALL_HALF_WIDTH:
                floor = FORT_LEVEL if wall_offset <= 0 else max(SURFACE, FORT_LEVEL - ceil(wall_offset))
                material = ground_material(x, z, variant, FORTIFIED_GROUND)
                ground = ((SURFACE+1, floor, 'stone'),) if floor > SURFACE else ()
                town_ground[x, z] = ground + ((floor, floor, material),)
            elif wall_offset >= MOAT_START + MOAT_WIDTH + BANK_WIDTH and radius <= town:
                town_ground[x, z] = ((80, 80, ground_material(x, z, variant, OUTER_TOWN_GROUND)),)
            if MOAT_START <= wall_offset < MOAT_START + MOAT_WIDTH:
                bank_distance = min(wall_offset-MOAT_START, MOAT_START+MOAT_WIDTH-wall_offset)
                if bank_distance < 1:
                    bottom = 75
                elif bank_distance < 2:
                    bottom = 72
                elif bank_distance < 5:
                    bottom = 71
                else:
                    bottom = MOAT_BOTTOM
                surfaces[x, z] = ((bottom, bottom, MOAT_LOWER[noise % len(MOAT_LOWER)]),
                                  (bottom+1, 79, 'water[level=0]'), (80, 80, 'air'))
            elif (MOAT_START - 1.4 <= wall_offset < MOAT_START
                  or MOAT_START + MOAT_WIDTH <= wall_offset < MOAT_START + MOAT_WIDTH + 1.4):
                surfaces[x, z] = ((76, 77, MOAT_LOWER[noise % len(MOAT_LOWER)]),
                                  (78, 80, MOAT_UPPER[noise // 3 % len(MOAT_UPPER)]))
                if not is_road and noise < 5:
                    rock = ('cobblestone', 'mossy_cobblestone', 'stone')[noise % 3]
                    surfaces[x, z] += ((81, 82 if noise < 2 else 81, rock),)
                    if noise in (0, 3):
                        level = 83 if noise == 0 else 82
                        surfaces[x, z] += ((level, level, 'mossy_cobblestone_wall'),)
            if is_road and radius >= 17 and not (MOAT_START <= wall_offset < MOAT_START + MOAT_WIDTH):
                road_block = 'dirt_path' if noise < 22 else ('coarse_dirt', 'gravel')[noise % 2]
                surfaces[x, z] = surfaces.get((x, z), ()) + ((80, 80, road_block),)
                if wall_offset < 9:
                    floor = FORT_LEVEL - max(0, min(FORT_LEVEL-SURFACE, int(wall_offset)-3))
                    if floor > SURFACE:
                        inward = ('west' if dx > 0 else 'east') if abs(dx) > abs(dz) else (
                            'north' if dz > 0 else 'south')
                        ramp = f'stone_brick_stairs[facing={inward}]' if 4 <= wall_offset < 8 else 'stone_bricks'
                        surfaces[x, z] += ((SURFACE+1, floor, 'stone_bricks'), (floor, floor, ramp))

            if abs(wall_offset) < WALL_HALF_WIDTH:
                y = walk_height(angle)
                base = (
                    (81, 83, ('deepslate_bricks', 'cobbled_deepslate', 'cracked_deepslate_bricks')[noise % 3]),
                    (84, 86, ('tuff_bricks', 'tuff', 'polished_tuff')[noise // 3 % 3]),
                    (87, y - 1, ('stone_bricks', 'mossy_stone_bricks', 'cracked_stone_bricks')[noise // 7 % 3]),
                )
                if is_road:
                    base = ((FORT_LEVEL+1, y-1, 'air'),)
                deck = 'stone_bricks'
                if abs(wall_offset) <= WALK_HALF_WIDTH:
                    deck = ('spruce_slab[type=top]' if noise == 0 else
                            'stripped_spruce_wood' if noise % 9 == 0 else 'spruce_planks')
                    walk_cells[x, z] = deck
                    walk_levels[x, z] = y
                stack = base + ((y, y, deck),)
                if (x, z) not in walk_cells:
                    if noise % 7 == 0:
                        ornament = 'stone_brick_stairs[half=top]'
                        stack += ((y - 1, y - 1, ornament),)
                    elif noise % 11 == 0:
                        stack += ((y - 1, y - 1, 'stone_brick_slab[type=top]'),)
                    along = arc_length[min(720, int((angle+pi)*360/pi))]
                    merlon = along % merlon_period < merlon_period*0.42
                    parapet[x, z] = (y, merlon)
                    if merlon:
                        stack += ((y+1, y+2, 'stone_bricks'),)
                    else:
                        stack += ((y+1, y+1, 'stone_brick_slab[type=bottom]'),)
                masonry[x, z] = stack
            if not is_road and abs(radius - town) < 0.75:
                wall_palette = LOW_WALL_STONE + LOW_WALL_DETAILS
                low_wall = wall_palette[noise % len(wall_palette)]
                surfaces[x, z] = ((81, 81, low_wall),
                                  (82, 82, ('stone_brick_wall', 'cobblestone_wall', 'spruce_fence',
                                            'oak_leaves[persistent=true]')[noise % 4]))
                if noise % 5 == 0:
                    surfaces[x, z] += ((83, 83, 'mossy_cobblestone_wall'),)
            if (town + 1.2 < radius < border - fence_half_width - FENCE_CLEARANCE
                    and road_distance > road_half_width + 3):
                depth = radius - town - 1.2
                hill = 2 + 1.1*sin(3*angle + origin) + 0.65*sin(depth/6 + origin)
                rise = max(0, round(min(1, depth/12)*hill))
                y = 80 + rise
                partition = int((angle + pi) * (10 + variant % 2) / (2*pi))
                track = (angle + pi) * (10 + variant % 2) / (2*pi) % 1 < 0.028
                crop = ('wheat', 'carrots', 'potatoes')[partition % 3]
                farm_levels[x, z] = y
                stack = ((81, y, 'dirt'),) if rise else ()
                if track:
                    stack += ((y, y, 'packed_mud'),)
                    if int(depth) % 19 not in (0, 1, 2):
                        stack += ((y + 1, y + 1, 'spruce_fence'),)
                else:
                    stack += ((y, y, 'farmland[moisture=7]'), (y + 1, y + 1, f'{crop}[age=7]'))
                farms[x, z] = stack
            if not is_road and not in_fence_gap and abs(radius - border) <= fence_half_width:
                height = 2 if sin(7*angle + origin) > 0.5 else 1
                post = ('spruce_fence', 'oak_leaves[persistent=true]', 'spruce_fence',
                        'spruce_log', 'oak_leaves[persistent=true]')[noise % 5]
                surfaces[x, z] = ((81, 80 + height, post),)

            signed = radius - border
            verge_depth = abs(signed) - fence_half_width
            if (not in_fence_gap and 1 < verge_depth < FENCE_CLEARANCE - 0.6
                    and road_distance > road_half_width + 4):
                verge_candidates[int(signed > 0)].append((x, z))

    for side, candidates in enumerate(verge_candidates):
        rng_verge = Random(4283 + variant + 151*side)
        rng_verge.shuffle(candidates)
        details = []
        for x, z in candidates:
            if len(details) >= 28:
                break
            if any(hypot(x-xx, z-zz) < 8 for xx, zz in details):
                continue
            details.append((x, z))
            block = rng_verge.choice(('spruce_fence', 'oak_leaves[persistent=true]', 'stone',
                                     'cobblestone', 'stone_slab[type=bottom]', 'cobblestone_slab[type=bottom]'))
            height = 2 if block in ('spruce_fence', 'oak_leaves[persistent=true]') and rng_verge.random() < 0.3 else 1
            surfaces[x, z] = ((81, 80+height, block),)

    adjacent = ((-1, 0), (1, 0), (0, -1), (0, 1))
    planted = {pos for pos, stack in farms.items() if stack[-1][2].endswith('[age=7]')}
    retaining = {
        (x, z) for x, z in planted if farm_levels[x, z] > SURFACE
        and any((x + dx, z + dz) not in planted
                and farm_levels.get((x + dx, z + dz), SURFACE) < farm_levels[x, z]
                for dx, dz in adjacent)
    }
    for (x, z), y in farm_levels.items():
        neighbors = [(x + dx, z + dz) for dx, dz in adjacent]
        if (x, z) in retaining:
            ground = min(farm_levels.get(pos, SURFACE) for pos in neighbors if pos not in planted)
            material = RETAINING_PALETTE[(x*7 + z*11 + variant) % len(RETAINING_PALETTE)]
            farms[x, z] = ((81, ground, 'dirt'),) if ground > SURFACE else ()
            farms[x, z] += ((ground + 1, y, material),)
        elif x % 6 == z % 6 == 0 and all(
                farm_levels.get(pos) == y and pos not in retaining for pos in neighbors):
            stack = farms[x, z]
            if stack[-1][2].endswith('[age=7]'):
                farms[x, z] = stack[:-2] + ((y, y, 'water[level=0]'),)

    paint(town_ground)
    paint(surfaces)
    paint(farms)
    paint(masonry)

    for index in range(22):
        angle = 2*pi*(index + 0.4)/22
        if min(abs(sin(angle)), abs(cos(angle))) < 0.10:
            continue
        edge = trace(angle) + 2
        x, z = CENTER + round(edge*cos(angle)), CENTER + round(edge*sin(angle))
        y = walk_height(angle)
        box(x-1, z-1, x+1, z+1, 81, 81, 'polished_deepslate')
        box(x, z, x, z, 82, 84, 'deepslate_bricks')
        box(x, z, x, z, 85, y - 2, 'stone_brick_wall')
        cap = 'chiseled_stone_bricks' if index % 4 == 0 else 'stone_bricks'
        box(x, z, x, z, y - 1, y - 1, cap)

    def weather_facade(left, front, right, back, bottom, middle, upper, top):
        for y in range(bottom, top):
            if y < middle:
                palette = ('cracked_deepslate_bricks', 'cobbled_deepslate')
                carved = 'chiseled_deepslate'
            elif y < upper:
                palette = ('tuff', 'polished_tuff')
                carved = 'chiseled_tuff_bricks'
            else:
                palette = ('cracked_stone_bricks', 'mossy_stone_bricks',
                           'stone_brick_stairs[half=top]', 'stone_brick_slab[type=top]')
                carved = 'chiseled_stone_bricks'
            edge = [(x, z) for x in range(left, right+1) for z in (front, back)]
            edge.extend((x, z) for x in (left, right) for z in range(front+1, back))
            for x, z in edge:
                grain = (x*73 ^ z*97 ^ y*43 ^ variant*11) % 31
                patch = (x//4 * 11 + z//4 * 17 + y//2 * 19 + variant) % 13
                if grain == 0 and patch == 0:
                    box(x, z, x, z, y, y, carved)
                elif grain < 5 or patch < 2:
                    box(x, z, x, z, y, y, palette[(grain + patch) % len(palette)])

    def tower(x, z, radius, bottom, top):
        box(x-radius, z-radius, x+radius, z+radius, bottom, bottom+3, 'deepslate_bricks')
        box(x-radius, z-radius, x+radius, z+radius, bottom+4, top-4, 'tuff_bricks')
        box(x-radius, z-radius, x+radius, z+radius, top-3, top, 'stone_bricks')
        weather_facade(x-radius, z-radius, x+radius, z+radius, bottom, bottom+4, top-3, top)
        box(x-radius+1, z-radius+1, x+radius-1, z+radius-1, top, top, 'stone_bricks')
        for offset in range(-radius, radius+1, 2):
            for edge in (-radius, radius):
                box(x+offset, z+edge, x+offset, z+edge, top+1, top+2, 'stone_brick_wall')
                box(x+edge, z+offset, x+edge, z+offset, top+1, top+2, 'stone_brick_wall')
        for edge in (-radius, radius):
            box(x+edge, z, x+edge, z, bottom+5, bottom+7, 'polished_tuff')
            box(x, z+edge, x, z+edge, top-3, top-2, 'air')

    tower_sites = []
    gate_sites = []
    for index, angle in enumerate((0.66, 2.4, 3.5, 5.5)):
        r = trace(angle)
        x, z = CENTER + round(r*cos(angle)), CENTER + round(r*sin(angle))
        radius = 3 + (index + variant) % 2
        tower_sites.append((x, z, radius))
        tower(x, z, radius, 81, 98 + (index*3 + variant*2) % 9)
        # Restore the wall deck through the tower itself.
        for cz in range(z-radius, z+radius+1):
            for cx in range(x-radius, x+radius+1):
                if (cx, cz) in walk_cells:
                    y = walk_height(atan2(cz-CENTER, cx-CENTER))
                    box(cx, cz, cx, cz, y, y, walk_cells[cx, cz])
                    box(cx, cz, cx, cz, y+1, y+3, 'air')
                    # Keep the walking area clear below the curved stone crown.
                    faces = ((1, 0, 'east'), (-1, 0, 'west'), (0, 1, 'south'), (0, -1, 'north'))
                    edge = next((face for dx, dz, face in faces
                                 if (cx+dx, cz+dz) not in walk_cells), None)
                    if edge:
                        box(cx, cz, cx, cz, y+3, y+3, f'stone_brick_stairs[facing={edge},half=top]')
                    else:
                        box(cx, cz, cx, cz, y+4, y+4, 'stone_brick_slab[type=top]')

    # Access stair on the inside of the south wall.
    gate = CENTER + round(trace(pi/2))
    ywalk = walk_height(pi/2)
    for step in range(ywalk - FORT_LEVEL):
        z = gate - (ywalk - FORT_LEVEL) - 2 + step
        box(CENTER+4, z, CENTER+6, z, FORT_LEVEL+1, FORT_LEVEL+1+step, 'stone_bricks')
        box(CENTER+4, z, CENTER+6, z, FORT_LEVEL+1+step, FORT_LEVEL+1+step,
            'stone_brick_stairs[facing=south]')
    box(CENTER+2, gate-2, CENTER+6, gate-2, ywalk, ywalk, 'stone_bricks')
    for vx, vz in ENTRY_VECTORS:
        angle = atan2(vz, vx)
        distance = round(trace(angle))
        x, z = CENTER+vx*distance, CENTER+vz*distance
        deck = walk_height(angle)
        if vx:
            bounds = (x-2, z-4, x+2, z+4)
            passage = (x-2, z-2, x+2, z+2)
        else:
            bounds = (x-4, z-2, x+4, z+2)
            passage = (x-2, z-2, x+2, z+2)
        gate_sites.append(bounds)
        box(*bounds, 81, 83, 'deepslate_bricks')
        box(*bounds, 84, 87, 'tuff_bricks')
        box(*bounds, 88, deck-1, 'stone_bricks')
        box(*bounds, deck, deck, 'stone_bricks')
        weather_facade(*bounds, 81, 84, 88, deck)
        for cx in range(bounds[0], bounds[2]+1):
            for cz in range(bounds[1], bounds[3]+1):
                if (cx, cz) in walk_cells:
                    walk_levels[cx, cz] = deck
                    box(cx, cz, cx, cz, deck, deck, walk_cells[cx, cz])
        box(*passage, FORT_LEVEL, FORT_LEVEL, 'stone_bricks')
        box(*passage, FORT_LEVEL+1, deck-1, 'air')
        if vx:
            for zz in (z-4, z+4):
                for xx in range(x-2, x+3, 2):
                    box(xx, zz, xx, zz, deck+1, deck+2, 'stone_bricks')
        else:
            for xx in (x-4, x+4):
                for zz in range(z-2, z+3, 2):
                    box(xx, zz, xx, zz, deck+1, deck+2, 'stone_bricks')
    # Three stepped bridges with a clear arch above the source-water surface.
    for vx, vz in ENTRY_VECTORS:
        angle = atan2(vz, vx)
        first_wet = ceil(trace(angle) + MOAT_START)
        arch_rise = 3
        start, end = first_wet-arch_rise-1, first_wet+MOAT_WIDTH+arch_rise
        inward, outward = {
            (0, 1): ('north', 'south'), (1, 0): ('west', 'east'),
            (0, -1): ('south', 'north'),
        }[vx, vz]
        # Quantize a single elliptical intrados to half-block heights.
        heights = []
        for column in range(MOAT_WIDTH):
            t = (2*column+1)/MOAT_WIDTH - 1
            heights.append(round(2*(79.5 + 2.5*sqrt(1-t*t)))/2)
        for distance in range(start, end+1):
            x, z = CENTER+vx*distance, CENTER+vz*distance
            from_start, from_end = distance-start, end-distance
            rise = min(arch_rise, from_start, from_end)
            deck = 80+rise
            edges = ((x,z-2),(x,z+2)) if vx else ((x-2,z),(x+2,z))
            width = (x,z-2,x,z+2) if vx else (x-2,z,x+2,z)
            tread = (x,z-1,x,z+1) if vx else (x-1,z,x+1,z)
            column = distance-first_wet
            if 0 <= column < MOAT_WIDTH:
                ceiling = heights[column]
                full_level = ceil(ceiling)
                if ceiling != full_level:
                    toward_bank = -1 if column < MOAT_WIDTH/2 else 1
                    neighbor = column+toward_bank
                    direction = inward if toward_bank < 0 else outward
                    if 0 <= neighbor < MOAT_WIDTH and heights[neighbor] == ceiling-0.5:
                        trim = f'stone_brick_stairs[facing={direction},half=top]'
                    else:
                        trim = 'stone_brick_slab[type=top]'
                    box(*width, full_level-1, full_level-1, trim)
                if full_level < deck and (column < 2 or column >= MOAT_WIDTH-2):
                    box(*width, full_level, deck-1, 'stone_bricks')
                elif full_level < deck:
                    for ex, ez in edges:
                        box(ex, ez, ex, ez, full_level, deck-1, 'stone_bricks')
            elif rise:
                box(*width, 80, deck-1, 'mossy_stone_bricks')
            material = 'spruce_planks' if 2 <= column < MOAT_WIDTH-2 else 'stone_bricks'
            if 1 <= from_start <= arch_rise:
                material = f'stone_brick_stairs[facing={outward}]'
            elif 1 <= from_end <= arch_rise:
                material = f'stone_brick_stairs[facing={inward}]'
            box(*tread, deck, deck, material)
            for edge_x, edge_z in edges:
                box(edge_x,edge_z,edge_x,edge_z,deck,deck,'stone_bricks')
                box(edge_x,edge_z,edge_x,edge_z,deck+1,deck+1,'stone_brick_wall')

    # Keep and its higher courtyard use coordinates relative to the layout center.
    c = CENTER
    base = CASTLE_LEVEL
    box(c-18, c-17, c+18, c+17, FORT_LEVEL+1, base, 'cobbled_deepslate')
    box(c-18, c-17, c+18, c+17, base, base, 'mossy_cobblestone')
    for step in range(base-FORT_LEVEL):
        z = c+22-step
        y = FORT_LEVEL+1+step
        box(c-2,z,c+2,z,FORT_LEVEL+1,y,'stone_bricks')
        box(c-2,z,c+2,z,y,y,'stone_brick_stairs[facing=north]')
    box(c-12,c-11,c+12,c+11,base+1,base+7,'deepslate_bricks')
    box(c-12,c-11,c+12,c+11,base+8,base+15,'tuff_bricks')
    box(c-12,c-11,c+12,c+11,base+16,base+22,'stone_bricks')
    weather_facade(c-12,c-11,c+12,c+11,base+1,base+8,base+16,base+22)
    box(c-10,c-9,c+10,c+9,base+1,base+21,'air')
    box(c-2,c+10,c+2,c+11,base+1,base+6,'air')
    box(c-9,c-8,c+9,c+8,base+22,base+22,'spruce_planks')
    for x in (c-14,c+14):
        for z in (c-13,c+13):
            tower(x,z,3,base+1,base+29)
    house_sites = []
    for index in range(10):
        angle = 2*pi*(index+0.42+variant*0.075)/10
        nearest = trace(angle) + MOAT_START + MOAT_WIDTH + BANK_WIDTH
        radius = (nearest + urban(angle))/2
        x, z = CENTER + round(radius*cos(angle)), CENTER + round(radius*sin(angle))
        dx, dz = x-CENTER, z-CENTER
        if any(abs(dx*vz - dz*vx) <= 6 and dx*vx + dz*vz > 0 for vx, vz in ENTRY_VECTORS):
            continue
        width, depth = (3 + index % 3), (3 + (index + variant) % 2)
        corners = ((x+sx*width, z+sz*depth) for sx in (-1, 1) for sz in (-1, 1))
        if any(not (trace(atan2(cz-CENTER, cx-CENTER)) + MOAT_START + MOAT_WIDTH
                    + BANK_WIDTH <= hypot(cx-CENTER, cz-CENTER)
                    < urban(atan2(cz-CENTER, cx-CENTER)) - 0.8) for cx, cz in corners):
            continue
        house_sites.append((x, z, width, depth))
        box(x-width, z-depth, x+width, z+depth, 81, 84, 'mossy_cobblestone' if index % 3 == 0 else 'stone_bricks')
        box(x-width+1, z-depth+1, x+width-1, z+depth-1, 81, 84, 'air')
        if abs(dx) > abs(dz):
            side = x-width if dx > 0 else x+width
            box(side, z, side, z+1, 81, 83, 'air')
        else:
            side = z-depth if dz > 0 else z+depth
            box(x, side, x+1, side, 81, 83, 'air')
        for step in range(3):
            box(x-width-1, z-depth-1+step, x+width+1, z+depth+1-step,
                85+step, 85+step, 'spruce_planks')
    rng = Random(3207 + variant)
    tree_sites = []

    def tree(x, z, base, tall):
        if not (7 <= x < SIZE-7 and 7 <= z < SIZE-7):
            return
        if any(abs(x-hx) <= width+5 and abs(z-hz) <= depth+5
               for hx, hz, width, depth in house_sites):
            return
        if any(hypot(x-tx, z-tz) < 6 for tx, tz in tree_sites):
            return
        tree_sites.append((x, z))
        leaves = rng.choice(('oak_leaves[persistent=true]', 'oak_leaves[persistent=true]',
                             'dark_oak_leaves[persistent=true]'))
        log = 'oak_log' if leaves.startswith('oak') else 'dark_oak_log'
        angle = rng.uniform(-pi, pi)
        crowns = [(x, z, base+tall-1, rng.randint(3, 4))]
        branches = []
        for limb in range(rng.randint(3, 5)):
            bearing = angle + limb*1.58 + rng.uniform(-0.38, 0.38)
            span = rng.randint(2, 4)
            start_y = base + tall - rng.randint(3, 5)
            for step in range(1, span+1):
                bx, bz = x + round(step*cos(bearing)), z + round(step*sin(bearing))
                by = start_y + (step+1)//2
                direction = 'x' if abs(cos(bearing)) >= abs(sin(bearing)) else 'z'
                branches.append((bx, bz, by, direction))
                if step <= span//2 and limb % 2 == 0:
                    branches.append((bx, bz, by-1, direction))
            crowns.append((bx, bz, by+1, rng.randint(2, 4)))
        for cx, cz, cy, radius in crowns:
            for dy in range(-1, 3):
                for dz in range(-radius, radius+1):
                    xs = [dx for dx in range(-radius, radius+1)
                          if dx*dx + dz*dz + 2*(dy-0.5)**2 <= radius*radius]
                    if xs:
                        box(cx+xs[0], cz+dz, cx+xs[-1], cz+dz, cy+dy, cy+dy, leaves)
        box(x, z, x, z, base, base, 'grass_block')
        box(x, z, x, z, base+1, base+tall-1, log)
        for bx, bz, by, direction in branches:
            box(bx, bz, bx, bz, by, by, f'{log}[axis={direction}]')

    for vx, vz in ENTRY_VECTORS:
        for distance in sorted(rng.sample(range(87, 102), rng.randint(2, 4))):
            side = rng.choice((-1, 1))
            offset = rng.randrange(4, 7)
            x, z = CENTER+vx*distance-vz*side*offset, CENTER+vz*distance+vx*side*offset
            if (x,z) not in farms and (x,z) not in surfaces:
                tree(x, z, SURFACE, rng.randint(7, 11))

    for sample in range(11):
        angle = rng.uniform(-pi, pi)
        for attempt in range(rng.choice((1, 2, 3, 5))):
            direction = angle + rng.uniform(-0.13, 0.13)
            zone = 'town' if sample % 3 == 0 else 'farm'
            midpoint = (urban(direction)+rural(direction)-6)/2 if zone == 'farm' else (
                        urban(direction)+trace(direction)+MOAT_START+MOAT_WIDTH+BANK_WIDTH)/2
            radius = midpoint + rng.uniform(-6, 6)
            x,z = CENTER+round(radius*cos(direction)), CENTER+round(radius*sin(direction))
            if min((abs((x-CENTER)*vz - (z-CENTER)*vx) for vx,vz in ENTRY_VECTORS
                    if (x-CENTER)*vx + (z-CENTER)*vz >= 0), default=SIZE) < 5:
                continue
            if zone == 'farm' and (x,z) in planted-retaining:
                tree(x, z, farm_levels[x,z], rng.randint(7, 11))
            elif zone == 'town' and (x,z) in town_ground and (x,z) not in surfaces:
                tree(x, z, SURFACE, rng.randint(7, 11))

    # Restore merlons at overlaps where the ground road and upper parapet cross.
    rim = {}
    for (x,z), (y, merlon) in parapet.items():
        in_tower = any(abs(x-tx) <= radius and abs(z-tz) <= radius for tx,tz,radius in tower_sites)
        in_gate = any(x1 <= x <= x2 and z1 <= z <= z2 for x1,z1,x2,z2 in gate_sites)
        if not in_tower and not in_gate:
            rim[x,z] = ((y+1,y+2,'stone_bricks'),) if merlon else (
                (y+1,y+1,'stone_brick_slab[type=bottom]'), (y+2,y+2,'air'))
    paint(rim)

    # Lay out whole stair rows after all gate and tower heights have been set.
    corridor = {}
    for (x,z), y in walk_levels.items():
        stairs = []
        for dx,dz,facing in ((-1,0,'east'), (1,0,'west'), (0,-1,'south'), (0,1,'north')):
            if walk_levels.get((x+dx,z+dz)) == y-1:
                votes = sum(walk_levels.get((x+dx+sx,z+dz+sz)) == y-1
                            for sx,sz in ((-abs(dz),-abs(dx)), (0,0), (abs(dz),abs(dx))))
                stairs.append((votes, facing))
        deck = f'spruce_stairs[facing={max(stairs)[1]}]' if stairs else walk_cells[x,z]
        corridor[x,z] = ((y,y,deck), (y+1,y+2,'air'))
    paint(corridor)

    # Resolve the final shapes before replacing awkward connections with solid posts.
    narrow = {}
    for x,z,xx,zz,y,yy,material in regions:
        block = material.split('[', 1)[0]
        family = 'wall' if block.endswith('_wall') else 'fence' if block.endswith('_fence') else None
        for cx in range(x,xx+1):
            for cz in range(z,zz+1):
                for cy in range(y,yy+1):
                    key = cx,cy,cz
                    if family:
                        narrow[key] = family
                    elif key in narrow:
                        del narrow[key]
    solid_posts = set()
    for (x,y,z), family in sorted(narrow.items()):
        square = [(x,y,z),(x+1,y,z),(x,y,z+1),(x+1,y,z+1)]
        if all(narrow.get(pos) == family for pos in square) and not solid_posts.intersection(square):
            solid_posts.add(square[-1])
        if family == 'wall':
            horizontal = any(narrow.get((x+dx,y,z)) == 'wall' for dx in (-1,1))
            vertical = any(narrow.get((x,y,z+dz)) == 'wall' for dz in (-1,1))
            diagonal = any(narrow.get((x+dx,y,z+dz)) == 'wall'
                           and (x+dx,y,z) not in narrow and (x,y,z+dz) not in narrow
                           for dx in (-1,1) for dz in (-1,1))
            if horizontal and vertical or diagonal:
                solid_posts.add((x,y,z))
    for x,y,z in sorted(solid_posts):
        post = 'stone_bricks' if narrow[x,y,z] == 'wall' else 'spruce_log'
        box(x,z,x,z,y,y,post)
    return regions


layouts = [create_layout(variant) for variant in range(LAYOUTS)]


def assign(name, value):

    return f'scoreboard players set #{name} {OBJECTIVE} {value}'





def matches(name, value):

    return f'if score #{name} {OBJECTIVE} matches {value}'





tiles = [(x, z) for z in range(0, SIZE, TILE) for x in range(0, SIZE, TILE)]

dispatch = []

for index, (x, z) in enumerate(tiles):

    end_x, end_z = x + TILE - 1, z + TILE - 1

    area = f'{x} {z} {end_x} {end_z}'

    prefix = f'tile/{index}'

    ready = ' '.join(

        f'if loaded {cx} {SURFACE} {cz}'

        for cx in range(x, end_x + 1, 16)

        for cz in range(z, end_z + 1, 16)

    )

    dispatch.append(f'execute {matches("tile", index)} run return run {call(prefix + "/tick")}')

    function(prefix + '/tick', [

        f'execute {matches("loading", 0)} run return run {call(prefix + "/load")}',

        f'execute {ready} run {call(prefix + "/apply")}',

    ])

    function(prefix + '/load', [f'forceload add {area}', assign('loading', 1)])

    def tile_commands(placements):

        for x1, z1, x2, z2, y1, y2, material in placements:

            left, right = max(x, x1), min(end_x, x2)

            top, bottom = max(z, z1), min(end_z, z2)

            if left <= right and top <= bottom:

                for layer in range(y1, y2 + 1, 4):

                    yield fill(left, layer, top, right, min(layer + 3, y2), bottom, material)



    commands = []
    for variant, placements in enumerate(layouts):
        name = f'{prefix}/layout_{variant}'
        function(name, list(tile_commands(placements)))
        commands.append(f'execute {matches("layout", variant)} run {call(name)}')
    function(prefix + '/build', commands)
    function(prefix + '/clear', [

        *[fill(x, y, z, end_x, y + 3, end_z, 'air') for y in range(81, 125, 4)],

        fill(x, MOAT_BOTTOM, z, end_x, 73, end_z, 'stone'),
        fill(x, 74, z, end_x, 77, end_z, 'stone'),
        fill(x, 78, z, end_x, 79, end_z, 'dirt'),
        fill(x, SURFACE, z, end_x, SURFACE, end_z, 'grass_block'),

        f'kill @e[type=!minecraft:player,x={x},y={MOAT_BOTTOM},z={z},dx={TILE-1},dy={MAX_Y-MOAT_BOTTOM},dz={TILE-1}]',

    ])

    function(prefix + '/apply', [

        f'execute {matches("state", 1)} run {call(prefix + "/build")}',

        f'execute {matches("state", 3)} run {call(prefix + "/clear")}',

        f'forceload remove {area}',

        assign('loading', 0),

        f'scoreboard players add #tile {OBJECTIVE} 1',

    ])



function('load', [f'scoreboard objectives add {OBJECTIVE} dummy'])

function('tick', [

    f'execute {matches("state", 1)} in {DIMENSION} run {call("city/work")}',

    f'execute {matches("state", 3)} in {DIMENSION} run {call("city/work")}',

    f'execute {matches("state", 2)} as @a[tag=cc13_visit] run {call("city/arrive")}',

    f'execute {matches("state", 0)} as @a[tag=cc13_reset] run {call("city/reset_notice")}',

])

function('city/work', [

    f'execute {matches("tile", len(tiles))} run return run {call("city/finish")}',

    *dispatch,

])

function('city/finish', [

    f'execute {matches("state", 1)} run return run {assign("state", 2)}',

    assign('state', 0),

])

function('city/roll_layout', [
    f'execute unless score #layout {OBJECTIVE} matches 0..{LAYOUTS - 1} '
    f'run return run execute store result score #layout {OBJECTIVE} run random value 0..{LAYOUTS - 1}',
    f'execute store result score #offset {OBJECTIVE} run random value 1..{LAYOUTS - 1}',
    f'scoreboard players operation #layout {OBJECTIVE} += #offset {OBJECTIVE}',
    f'execute {matches("layout", f"{LAYOUTS}..")} run scoreboard players remove #layout {OBJECTIVE} {LAYOUTS}',
])
function('city/start', [
    call('city/roll_layout'), assign('tile', 0), assign('loading', 0), assign('state', 1),
])
function('visit', [

    f'execute {matches("state", 3)} run return run tellraw @s "Aguarde o reset."',

    f'execute {matches("state", 2)} run return run {call("city/arrive")}',

    'tag @s add cc13_visit',

    f'execute unless score #state {OBJECTIVE} matches 1 run {call("city/start")}',

    'tellraw @s "Preparando a capital de 400 × 400. Voce sera teleportado ao concluir."',

])

function('city/arrive', [

    'tag @s remove cc13_visit',

    f'execute in {DIMENSION} run teleport @s {SPAWN} 180 0',

    call('status'),

])

function('status', [

    f'execute {matches("state", 1)} run return run tellraw @s ["Gerando setores: ",{{"score":{{"name":"#tile","objective":"{OBJECTIVE}"}}}},"/{len(tiles)}"]',

    f'execute {matches("state", 3)} run return run tellraw @s "Reset em andamento."',

    f'execute unless score #state {OBJECTIVE} matches 2 run return run tellraw @s "Use /function capital_cities:visit para gerar a capital."',

    f'tellraw @s ["Capital 0.13.1 | Planta ",{{"score":{{"name":"#layout","objective":"{OBJECTIVE}"}}}}]',

])

function('reset', [

    assign('occupied', 0),

    f'execute as @a at @s if dimension {DIMENSION} run {assign("occupied", 1)}',

    f'execute {matches("occupied", 1)} run return run tellraw @s "Todos devem sair da capital antes do reset."',

    f'execute unless score #state {OBJECTIVE} matches 2 run return run tellraw @s "O reset exige uma capital pronta. Consulte /function capital_cities:status."',

    'tag @s add cc13_reset',

    assign('tile', 0),

    assign('loading', 0),

    assign('state', 3),

    'tellraw @s "Limpando a planta da assentamento 0.13."',

])

function('city/reset_notice', [

    'tag @s remove cc13_reset',

    'tellraw @s "Planta limpa. Use /function capital_cities:visit para reconstruir."',

])



files['LEIA-ME.txt'] = f"""Capital Cities {VERSION} — Minecraft Java {MINECRAFT_VERSION}

Instale o ZIP em datapacks num mundo novo, feche e reabra o mundo.
Anote coordenadas seguras no Overworld. Rode /function capital_cities:visit.
A geração cobre 400 × 400 blocos em 25 setores. Use /function capital_cities:status.
Siga para o norte pelas lavouras, atravesse a cidade externa e o fosso até o castelo.
Para voltar, use /execute in minecraft:overworld run tp @s <x> <y> <z>.
Com todos fora da dimensão, use /function capital_cities:reset para limpar a área.
A visita seguinte sorteia outra das quatro plantas. O reset remove alterações entre Y 70 e 124.
O fosso de 16 blocos fica fundo logo após as margens. As pontes são baixas,
com miolo de abeto. A fortificação e o castelo ocupam patamares sucessivos.
Use um mundo novo para o mapa de 400 × 400.
"""

output = Path(__file__).resolve().parents[1] / 'dist' / f'capital_cities_v{VERSION}_mc{MINECRAFT_VERSION}.zip'

output.parent.mkdir(parents=True, exist_ok=True)

with ZipFile(output, 'w', ZIP_DEFLATED) as archive:

    for path, content in files.items():

        archive.writestr(path, content)

with ZipFile(output) as archive:

    assert archive.testzip() is None

print(f'{output} ({len(files)} files)')

