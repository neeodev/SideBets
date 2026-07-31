SideBets.register_joker {
    id = "patchwork",
    rarity = "Uncommon",
    cost = 6,
    pos = { x = 1, y = 1 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1.75,
            required_suits = 4,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        local extra = card.ability.extra
        return { vars = { extra.xmult, extra.required_suits } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local extra = card.ability.extra
            local _, suits = SideBets.native_suit_set(context.scoring_hand, { ignore_wild = true })
            if suits >= extra.required_suits then
                return { x_mult = extra.xmult }
            end
        end
    end,
}
