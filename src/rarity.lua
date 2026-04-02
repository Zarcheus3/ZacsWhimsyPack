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
        ["Joker"] = true
    },
    

}
SMODS.Rarity {
    key = "l_whimsical",
    default_weight = 0,
    badge_colour = HEX('ab08d4'),
    loc_txt = {
        name = "Whimsical Legend"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
    disable_if_empty = true,
    pools = {
        ["Joker"] = true
    },
}