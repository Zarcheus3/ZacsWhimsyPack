SMODS.Consumable:take_ownership("c_soul",{
  -- new use function here
    key = 'soul',
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({set = "zwp_l_whims"})
                
                check_for_unlock { type = 'spawn_legendary' }
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
}, true) -- remove the comma the the true to make your mod badge show on the soul