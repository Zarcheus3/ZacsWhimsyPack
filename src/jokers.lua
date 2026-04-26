
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
-- coin
SMODS.Joker{
    key = "coin",
    atlas = "woker",
    pos = {
        x = 1,
        y = 2
    },
    config = {
        extra = {
            xmult1 = 2,
            xmult2 = 0.5,
            odds = 3,
            dollars = 2
        }
    },
    rarity = 2,
    price = 3,
    loc_vars = function(self, info_queue, card)
        local has_whimsy = false
        for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        has_whimsy = true
                    end
        end
        info_queue[#info_queue+1] = G.P_CENTERS.m_zwp_whimsical
        local numerator1, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_coin')
        local numerator2, denominator = SMODS.get_probability_vars(card, 2, card.ability.extra.odds, 'zwp_coin')
        return { key = has_whimsy and "j_zwp_coin_alt" or nil, vars = { numerator1,numerator2, denominator, card.ability.extra.xmult1, card.ability.extra.xmult2, card.ability.extra.dollars} }
        
    end,
    calculate = function(self,card, context)
        if context.joker_main then
            local has_whimsy = false
            for _, playing_card in ipairs(G.playing_cards or {}) do
                        if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                            has_whimsy = true
                        end
            end
            if has_whimsy == false then
                if SMODS.pseudorandom_probability(card, 'zwp_coin', 2, card.ability.extra.odds) then
                    return {
                        x_mult = card.ability.extra.xmult1
                    }
                else
                    return{
                        x_mult = card.ability.extra.xmult2
                    }
                end
            end
            if has_whimsy == true then
                if SMODS.pseudorandom_probability(card, 'zwp_coin', 1, card.ability.extra.odds) then
                    return {
                        x_mult = card.ability.extra.xmult1
                    }
                else
                    return{
                        x_mult = card.ability.extra.xmult2
                    }
                end
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        local has_whimsy = false
        for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        has_whimsy = true
                    end
        end
        if has_whimsy then
            return card.ability.extra.dollars
        end
    end
    
}
-- pencil
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
    blueprint_compat = false,
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


-- Whimsical Jokers

-- gnome
SMODS.Joker{
    key = "garden",
    atlas = "woker",
    pos = {
        x = 2,
        y = 1
    },
    rarity = 1,
    cost = 4,
    weight = 20,
    set_badges = function(self, card, badges)
 	    badges[#badges + 1] = create_badge('Whimsical', HEX('FF1AFF'), G.C.WHITE, 1.2 )
    end,
    config = {
        extra = {
            mult = 10,

        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zwp_whimsical
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_zwp_whimsical') then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.mult
            return {
                mult = card.ability.extra.mult,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
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

-- bundle of whimsy
SMODS.Joker{
    key = "bundle",
    atlas = "woker",
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = {
            card_count = 4
        }
    },
    set_badges = function(self, card, badges)
 	    badges[#badges + 1] = create_badge('Whimsical', HEX('FF1AFF'), G.C.WHITE, 1.2 )
    end,
    cost = 2,
    rarity = 1,
    weight = 25,
    eternal_compat = false,
    blueprint_compat = false,
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zwp_whimsical
        return {vars = {card.ability.extra.card_count}}
    end,
    calculate = function(self, card, context)
        
        if context.selling_self and G.STATE == G.STATES.SELECTING_HAND then
            for i = 1, card.ability.extra.card_count do
                SMODS.add_card{set = 'Playing Card', enhancement = 'm_zwp_whimsical' }
            end
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

-- vortex
SMODS.Joker{
    key = "vortex",
    atlas = "woker",
    pos = {
        x = 0,
        y = 2
    },
    
    config = {
        extra = {
            emult = 0.03
        }
    },
    weight = 20,
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





-- Evil Jokers

-- banana and rot
SMODS.Joker{
    key = "scarynana",
    atlas = "woker",
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            odds = 8,
            xmult = 1.5
        }
    },
    weight = 15,
    loc_vars = function(self, info_queue, card)
        
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_scarynana')
        return { vars = { numerator, denominator, card.ability.extra.xmult} }
    end,
    rarity = 1,
    cost = 4,
    eternal_compat = false,
    in_pool = function(self, args)
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        return false
                    end
                end
                return true
                
    end,
    
    set_badges = function(self, card, badges)
 	    badges[#badges + 1] = create_badge('Evil', HEX('690404'), G.C.WHITE, 1.2 )
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'zwp_scarynana', 1, card.ability.extra.odds) then
                card:set_ability("j_zwp_rot")
                return {
                    message = {
                        "Rotted!",
                        
                    }
                }
            else
                return {
                    message = "Safe"
                }
            end
        end
    end
}
SMODS.Joker{
    key = "rot",
    atlas = "woker",
    pos = {
        x = 1,
        y = 1
    },
    config = {
        extra = {
            odds = 6,
            xmult = 0.1
        }
    },
    in_pool = function(self, args)
        return false
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge('Evil', HEX('690404'), G.C.WHITE, 1.2 )
    end,
    rarity = 1,
    cost = 0,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_rot')
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zwp_whimsical
        local whimsy_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then whimsy_tally = whimsy_tally + 1 end
            end
        end
        return { vars = { numerator, denominator, card.ability.extra.xmult, 1 + card.ability.extra.xmult * whimsy_tally } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'zwp_rot', 1, card.ability.extra.odds) then
            return {remove = true}
        end
        
        if context.joker_main then
            local whimsy_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then whimsy_tally = whimsy_tally + 1 end
            end
            return {
                x_mult = 1 + card.ability.extra.xmult * whimsy_tally,
            }
        end
    end,

}

-- monkey
SMODS.Joker{
    key = "monkey",
    atlas = "woker",
    pos = {
        x = 2,
        y = 2
    },
    config = {
        extra = {
            odds = 3,
            xmult_gain = 0.25,
            xmult = 1
        }
    },
    weight = 15,
    in_pool = function(self, args)
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if SMODS.has_enhancement(playing_card, 'm_zwp_whimsical') then
                        return false
                    end
                end
                return true
                
    end,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'zwp_monkey')
        return { vars = { numerator, denominator, card.ability.extra.xmult, card.ability.extra.xmult_gain } }
        
    end,
    set_badges = function(self, card, badges)
 	    badges[#badges + 1] = create_badge('Evil', HEX('690404'), G.C.WHITE, 1.2 )
    end,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        local counter = 0
        if context.after and not context.blueprint then
            
            for _, pcard in ipairs(context.scoring_hand) do
                if pcard:get_id() >= 11 and pcard:get_id() <= 13 and SMODS.pseudorandom_probability(card, 'zwp_monkey', 1, card.ability.extra.odds) then
                    counter = counter + 1
                    local newRank = pseudorandom("zwp_funnySeed",2,10)
                    local rankChange = (pcard:get_id() - newRank) * -1
                    
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.8,

                        func = function()
                            pcard:juice_up()
                            assert(SMODS.modify_rank(pcard, rankChange))
                            return true
                        end,
                        

                    }))
                    
                end
            end
            if counter > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                -- See note about SMODS Scaling Manipulation on the wiki
                                card.ability.extra.xmult = card.ability.extra.xmult +
                                    card.ability.extra.xmult_gain * counter
                                return true
                            end,
                            
                        }))
                        SMODS.calculate_effect(
                            {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult +
                                card.ability.extra.xmult_gain * counter } }
                            }, card)
                        return true
                    end
                }))
                return nil, true -- This is for Joker retrigger purposes
            end
            
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- jimbos jar and the debuff
SMODS.Joker{
    key = "jimjar",
    atlas = "placeholders",
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 20,
    eternal_compat = false,
    calculate = function(self,card, context)
        local is_in_shop = G.STATE == G.STATES.SHOP
        if context.selling_self and not is_in_shop then
            SMODS.add_card({key = "j_zwp_wompwomp"})
            SMODS.add_card({ set = 'Joker', rarity = "Legendary" })
            
        end
    end
}
SMODS.Joker{
    key = "curse",
    atlas = "placeholders",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {

        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge('Evil', HEX('690404'), G.C.WHITE, 1.2 )
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if card.config.center.discovered and initial then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:set_edition("e_negative")
                    card:add_sticker("eternal", true)
                    return true
                end
            }))
        end
    end,
    calculate = function(self,card, context)
        if context.blind_defeated then
            for _, joker in ipairs(G.jokers.cards) do
                joker.ability.zwp_curse_chosen = nil
                SMODS.debuff_card(joker,false,"zwp_curse")
            end
        end
        
        if context.after or context.setting_blind then
            -- this code is pretty much directly stolen from vanilla remade, my bad
            if G.jokers.cards[2] then
                local prev_chosen_set = {}
                local fallback_jokers = {}
                local jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.zwp_curse_chosen then
                        prev_chosen_set[G.jokers.cards[i]] = true
                        G.jokers.cards[i].ability.zwp_curse_chosen = nil
                        if G.jokers.cards[i].debuff then SMODS.debuff_card(G.jokers.cards[i],false,"zwp_curse") end
                    end
                end
                for i = 1, #G.jokers.cards do
                    if not G.jokers.cards[i].debuff then
                        if not prev_chosen_set[G.jokers.cards[i]] then
                            jokers[#jokers + 1] = G.jokers.cards[i]
                        end
                        table.insert(fallback_jokers, G.jokers.cards[i])
                    end
                end
                if #jokers == 0 then jokers = fallback_jokers end
                local jcard = pseudorandom_element(jokers, 'zwp_random')
                while jcard.config.center.key == "j_zwp_curse" do
                    jcard = pseudorandom_element(jokers, 'zwp_random')
                end
                if jcard then
                    jcard.ability.zwp_curse_chosen = true
                    SMODS.debuff_card(jcard,true,"zwp_curse")
                    jcard:juice_up()
                    
                end
            end
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
    cost = 20,
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

