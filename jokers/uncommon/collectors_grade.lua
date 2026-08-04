SideBets.register_joker {
    id = "collectors_grade",
    rarity = "Uncommon",
    cost = 7,
    pos = { x = 3, y = 1 },
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
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other)
                and SideBets.has_enhancement(other)
                and SideBets.has_edition(other)
                and SideBets.has_seal(other)
            then
                return { x_mult = card.ability.extra.xmult }
            end
        end
    end,
}
