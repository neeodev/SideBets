SideBets.register_joker {
    id = "house_edge",
    rarity = "Common",
    cost = 5,
    pos = { x = 0, y = 2 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1.10,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.is_enhancement(other, "m_lucky") then
                return { x_mult = card.ability.extra.xmult }
            end
        end
    end,
}
