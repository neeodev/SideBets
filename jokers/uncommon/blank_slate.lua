SideBets.register_joker {
    id = "blank_slate",
    rarity = "Uncommon",
    cost = 6,
    pos = { x = 2, y = 1 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1.10,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.is_plain(other) then
                return { x_mult = card.ability.extra.xmult }
            end
        end
    end,
}
