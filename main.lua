
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

assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/rarity.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/tarot.lua"))()

