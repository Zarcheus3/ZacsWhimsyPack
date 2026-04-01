
SMODS.Consumable {
    key = "lollipop",
    set = "Tarot",
    atlas = "placeholders",
    pos = {
        x = 1,
        y = 2
    },
    config = { max_highlighted = 2, mod_conv = 'm_zwp_whimsical' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Whimsical', key = card.ability.mod_conv } } }
    end,
}