
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
        }
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
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_glass'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                return true
            end
        end
        return false
    end,
}