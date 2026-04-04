SMODS.Enhancement{
    key = "whimsical",
    atlas = "enhancements",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        
        extra = {mult = 0,odds = 10},
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_whimsical')
        return { vars = { card.ability.extra.mult, numerator, denominator,  } }
    end,
    calculate = function(self, card, context)
            if context.cardarea == G.play and context.destroy_card and context.destroy_card == card and 
            SMODS.pseudorandom_probability(card, 'zwp_whimsical', 1, card.ability.extra.odds) then
                    card:set_ability('c_base', nil, true)
                    local random_edition = SMODS.poll_edition { key = "modprefix_seed", guaranteed = true, no_negative = true } 
                    card:set_edition(random_edition, nil, nil, true) 
                    return {
                        message = "Evolved",
                        
                    }
            end

            
            
    end
}
