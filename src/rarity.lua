SMODS.Rarity {
    key = "whimsical",
    default_weight = 0.2,
    badge_colour = HEX('FF1AFF'),
    loc_txt = {
        name = "Whimsical"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
    disable_if_empty = true,

}