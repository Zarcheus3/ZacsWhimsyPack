SMODS.Rarity {
    key = "whimsical",
    default_weight = 0.15,
    badge_colour = HEX('FF1AFF'),
    loc_txt = {
        name = "Whimsical"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
    disable_if_empty = true,
    pools = {
        ["Joker"] = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                return true
            end
        end
        return false
        end,
    },
}    
-- put zwp_whimsical if you want to use this rarity on a joker

