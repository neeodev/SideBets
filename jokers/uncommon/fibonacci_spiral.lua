local FIB_RANKS = { [2] = true, [3] = true, [5] = true, [8] = true }

SideBets.register_joker {
    id = "fibonacci_spiral",
    rarity = "Uncommon",
    cost = 6,
    pos = { x = 2, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1.12,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.rank_in(other, FIB_RANKS) then
                return { x_mult = card.ability.extra.xmult }
            end
        end
    end,
}
