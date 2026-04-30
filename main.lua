
SMODS.Atlas({
    key = "modicon",
    path = "logo.png",
    px = 32,
    py = 32
})

SMODS.Atlas{
    key = "placeholders",
    path = "placeholders.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "enhancements",
    path = "enhancementsAtlas.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "tarots",
    path = "tarotsAtlas.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "woker",
    path = "jokersAtlas.png",
    px = 71,
    py = 95
}

loc_colour()
G.ARGS.LOC_COLOURS.zwp_evil = HEX('690404')
G.ARGS.LOC_COLOURS.zwp_whimsical = HEX('FF1AFF')

SMODS.current_mod.optional_features = {
    object_weights = true
}

assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/tarot.lua"))()
