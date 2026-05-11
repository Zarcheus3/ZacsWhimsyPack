
SMODS.Consumable {
    key = "lollipop",
    set = "Tarot",
    atlas = "consumables",
    pos = {
        x = 0,
        y = 0
    },
    weight = 12,
    config = { max_highlighted = 3, mod_conv = 'm_zwp_whimsical' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Whimsical', key = card.ability.mod_conv } } }
    end,
}

SMODS.Consumable {
    key = "fly",
    set = "Tarot",
    atlas = "consumables",
    pos = {
        x = 1,
        y = 0
    },
    cost = 0,
    in_pool = function(self, args)
        return false
    end,
    config = {
        
    },
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge("Sustenance", G.C.RED, G.C.WHITE, 1.2 )
    end
    --no_collection = true
}