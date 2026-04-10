
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

-Sets the badge with colors and new name and such

- For whimsical
set_badges = function(self, card, badges)
 	badges[#badges + 1] = create_badge('Whimsical', HEX('FF1AFF'), G.C.WHITE, 1.2 )
end,

- For evil
set_badges = function(self, card, badges)
 	badges[#badges + 1] = create_badge('Evil', HEX('690404'), G.C.WHITE, 1.2 )
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




SMODS.Joker{
    key = "exwhimsy",
    atlas = "placeholders",
    pos = {
        x = 0,
        y = 0
    },
    
    config = {
        extra = {
            emult = 0.02
        }
    },

    rarity = 3,
    cost = 10,
    set_badges = function(self, card, badges)
 	    badges[#badges + 1] = create_badge('Whimsical', HEX('FF1AFF'), G.C.WHITE, 1.2 )
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zwp_whimsical
        local whimsy_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then whimsy_tally = whimsy_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.emult, 1 + card.ability.extra.emult * whimsy_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local whimsy_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then whimsy_tally = whimsy_tally + 1 end
            end
            return {
                e_mult = 1 + card.ability.extra.emult * whimsy_tally,
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
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        return true
                    end
                end
                return false
                
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
