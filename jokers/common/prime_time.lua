local PRIME_RANKS = { [2] = true, [3] = true, [5] = true, [7] = true }

SideBets.register_joker {
    id = "prime_time",
    rarity = "Common",
    cost = 4,
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 6,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.rank_in(other, PRIME_RANKS) then
                return { mult = card.ability.extra.mult }
            end
        end
    end,
}
