local PRIME_COUNTS = { [2] = true, [3] = true, [5] = true, [7] = true }

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
            xmult = 1.5,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and PRIME_COUNTS[SideBets.scoring_count(context.scoring_hand)] then
            return { x_mult = card.ability.extra.xmult }
        end
    end,
}
