
SMODS.Rarity {
    key = "whimsical",
    default_weight = 5,
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
    }
}


-- put zwp_whimsical if you want to use this rarity on a joker

SMODS.Rarity {
    key = "evil",
    default_weight = 5,
    badge_colour = HEX('690404'),
    loc_txt = {
        name = "Evil"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
    disable_if_empty = true,
    pools = {
        ["Joker"] = true
    }
}


--[[
put this in joker if its whimsical
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
]]



--[[
put this in joker if its evil

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
]]