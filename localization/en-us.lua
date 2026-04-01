return {
    descriptions = {
        Joker = {
            --j is universal joker indicator, then id of mod, then joker id
            j_zwp_pencil = {
                name = "Triangular Pencil",
                text = {
                    "{C:chips}#1#{} chips"
                    --calls to the first entry in vars table in the jokers
                }
            }
        },
        Enhanced = {
            --m is univeral enhancement indicator
            m_zwp_whimsical = {
                name = "Whimsical",
                text = {{
                    "{C:green}#2# in #3#{} chance to",
                    "evolve up when played,",
                    "cards gain editions",
                    "when they evolve"
                },
                {
                    "Attracts Whimsical Jokers"
                }}

            }
        }
    }

}
