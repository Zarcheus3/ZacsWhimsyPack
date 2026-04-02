
SMODS.ObjectType({
    key = "zwp_l_whims",
    cards = {
        j_zwp_pencil = true,
        
    }
})

--{set = 'Joker', legendary = true}
for k, v in pairs(G.P_JOKER_RARITY_POOLS[4]) do
    SMODS.Joker:take_ownership(v.key, {
        pools = { ["zwp_l_whims"] = true },
    }, true)
end