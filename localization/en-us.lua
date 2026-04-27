return {
    descriptions = {
        Joker = {
            --j is universal joker indicator, then id of mod, then joker id
            j_zwp_pencil = {
                name = "Big Pencil",
                text = {
                    "{C:green}#1# in #2#{} chance to turn",
                    "each scored card without",
                    "an enhancement",
                    "into a {C:attention}Whimsical Card{}"
                    --calls to the first entry in vars table in the jokers
                }
            },
            j_zwp_coin = {
                name = "Gambler's Coin",
                text = {
                    "{C:green}#2# in #3#{} chance",
                    "to give {X:mult,C:white}X#4# {} Mult,",
                    "otherwise, give {X:mult,C:white}X#5#{} Mult",
                    "({C:inactive}Changes if you",
                    "{C:inactive} have {C:attention}Whimsical Cards{})"
                }
            },
            j_zwp_coin_alt = {
                name = "Lucky Coin",
                text = {
                    "{C:green}#1# in #3#{} chance",
                    "to give {X:mult,C:white}X#4#{} Mult,",
                    "otherwise, give {X:mult,C:white}X#5#{} Mult",
                    "Earn {C:money}$#6#{} at",
                    "end of round",
                    "({C:inactive}Changes if you", 
                    "{C:inactive}have no {C:attention}Whimsical Cards{})"
                }
            },
            j_zwp_propeller = {
                name = "Hat of Whimsy",
                text = {
                    "Retrigger all",
                    "played {C:attention}Whimsical Cards{}",
                    
                    "Played {C:attention}Whimsical Cards{} give",
                    "{X:mult,C:white}X#1# {} Mult when scored" 
                }
            },
            j_zwp_garden = {
                name = "Gnome's Garden",
                text = {
                    "Played {C:attention}Whimsical Cards{}",
                    "give {C:mult}+#1# {}Mult when scored"
                }
            },
            j_zwp_bundle = {
                name = "Bundle of Whimsy",
                text = {
                    "Sell this joker during",
                    "a blind to create",
                    "#1# {C:attention}Whimsical Cards{}"
                }
            },
            j_zwp_vortex = {
                name = "Vortex",
                text = {
                    "Gives {X:dark_edition,C:white}^#1#{} Mult for",
                    "each {C:attention}Whimsical Card{}",
                    "in your deck",
                    "{C:inactive}(Currently {X:dark_edition,C:white} ^#2# {C:inactive} Mult)"
                },
            },
            j_zwp_scarynana = {
                name = "Scary Banana",
                text = {
                    "{X:mult,C:white}X#3# {} Mult",
                    "{C:green}#1# in #2#{} chance this",
                    "card {C:attention}rots{} when",
                    "round ends"
                }
            },
            j_zwp_rot = {
                name = "Rot",
                text = {
                    "Gives {X:mult,C:white}X#3#{} Mult for",
                    "each card in your deck",
                    "that isn't {C:attention}Whimsical{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
                    "{C:green}#1# in #2#{} chance to",
                    "destroy played cards"
                }
            },
            j_zwp_monkey = {
                name = "Monkey",
                text = {
                    "After scoring,",
                    "{C:green}#1# in #2#{} chance to turn",
                    "each played {C:attention}face{} card into",
                    "a random numbered",
                    "rank, and gain {X:mult,C:white}X#4#{} Mult",
                    "on this joker",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_zwp_curse = {
                name = "Curse",
                text = {
                    "Disables one random",
                    "joker every hand"
                }
            },
            j_zwp_jimjar = {
                name = "Jimbo's Jar",
                text = {
                    "When sold, creates",
                    "a {C:legendary,E:1}Legendary{} joker",
                    "and a {C:mult,E:1}Curse{}"
                }
            }
        },
        
        Enhanced = {
            --m is univeral enhancement indicator
            m_zwp_whimsical = {
                name = "Whimsical Card",
                text = {{
                    "When played, {C:green}#2# in #3#{}",
                    "chance to remove",
                    "enhancement and evolve",
                    "into a random edition",
                    "{s:0.7,C:inactive}Attracts {X:zwp_whimsical,C:white,s:0.7}Whimsical{s:0.7,C:inactive} Jokers{}",
                    "{s:0.7,C:inactive}Deters {X:zwp_evil,C:white,s:0.7}Evil{s:0.7,C:inactive} Jokers{}"
                },
                }

            }
        },
        Tarot = {
            c_zwp_lollipop = {
                name = "The Lollipop",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Whimsical Cards{}"
                }
            }
        }
    }
}
