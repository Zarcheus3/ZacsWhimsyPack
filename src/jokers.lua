
--[[
joker template

SMODS.Joker{
    key = "joker",
    atlas = "placeholders",
    pos = {
        x = 3, 
        y = 0},
    config = {
        extra = {
            chips = -100
        }
        --denotes card abilities
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self,info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self,card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-Adjusts the badge with colors and new name and such

set_badges = function(self, card, badges)
 	badges[#badges] = create_badge('Whimsical', G.C.RED, G.C.BLACK, 1.2 )
end,






]]

SMODS.Joker{
    key = "pencil",
    atlas = "placeholders",
    pos = {
        x = 0,
        y = 0},
    config = {
        extra = {
            chips = -100
        },
        --denotes card abilities
    },
    
    rarity = "zwp_whimsical",
    cost = 5,
    
    loc_vars = function(self,info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self,card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                return true
            end
        end
        return false
    end,
}
















-- Legendary Jokers
SMODS.Joker{
    key = "propeller",
    atlas = "placeholders",
    pos = {
        x = 4,
        y = 0},
    config = {
        extra = {
            xmult = 1.5,
            repetitions = 1
        }
    },
    rarity = 4,
    cost = 10,
    
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_zwp_whimsical') then
            return {
                xmult = card.ability.extra.xmult
            }

        end
        if context.repetition and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_zwp_whimsical') then
                return{
                    repetitions = card.ability.extra.repetitions
                }
            end
        
    end,
    
}