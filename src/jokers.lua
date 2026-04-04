
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
    atlas = "woker",
    pos = {
        x = 2,
        y = 0},
    config = {
        extra = {odds = 5}
        
    },
    
    rarity = 2,
    cost = 5,
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_zwp_whimsical
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_pencil')
        return { vars = { numerator, denominator } }
        
    end,
    
    calculate = function(self,card, context)
        local counter = 0
        if context.before then
            for _, pcard in ipairs(context.scoring_hand) do
                if not next(SMODS.get_enhancements(pcard)) and SMODS.pseudorandom_probability(card, 'zwp_pencil', 1, card.ability.extra.odds) then
                    counter = counter + 1
                    pcard:set_ability("m_zwp_whimsical", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            pcard:juice_up()
                            
                            return true
                        end
                    }))
                    
                end
            end
            
        end
        if counter > 0 then
            return{
                message = "Whimsified"
            }
        end
        
    end
    
}
















-- Legendary Jokers
SMODS.Joker{
    key = "propeller",
    
    atlas = "woker",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    config = {
        extra = {
            xmult = 1.5,
            repetitions = 1
        }
    },
    loc_vars = function(self,info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_zwp_whimsical
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    rarity = 4,
    cost = 10,
    in_pool = function(self, args)
                local no_evil = true
                for i, v in ipairs(G.jokers.cards) do
                    if v:is_rarity("zwp_evil") then
                        no_evil = false
                        break
                    end
                end
                local has_whimsy = false
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        has_whimsy = true
                        break
                    end
                end
                if has_whimsy and no_evil then
                    return true
                else
                    return false
                end    
            end,
                
    set_badges = function(self, card, badges)
 	badges[#badges + 1] = create_badge('Whimsical Legend', HEX('B500B5'), G.C.WHITE, 1.2 )
    end,
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
--[[
for i, v in ipairs(G.jokers.cards) do
    if v:is_rarity("zwp_whimsical") then
        print("hi")
    end
end

this checks owned jokers for the whimsical joker
]]

SMODS.Joker {
    key = "evilman",
    atlas = "placeholders",
    pos = {
        x = 0,
        y = 0
    },
    rarity = "zwp_evil",
    in_pool = function(self)
        if G.jokers and G.jokers.cards and next(G.jokers.cards) then
            if next(SMODS.find_card("j_zwp_propeller")) then return false end
            for _, joker in ipairs(G.jokers.cards) do
                if joker:is_rarity("zwp_whimsical") then
                    return false
                end
            end
        end
        return true
    end,
}

SMODS.Joker {
    key = "whimsyman",
    atlas = "placeholders",
    pos = {
        x = 0,
        y = 0
    },
    rarity = "zwp_whimsical",
    in_pool = function(self, args)
                for i, v in ipairs(G.jokers.cards) do
                    if v:is_rarity("zwp_evil") then
                        return false
                    end
                end
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        return true
                    end
                end
                
                return false
                
            end,
}
