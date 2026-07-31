SideBets.register_joker {
    id = "color_theory",
    rarity = "Rare",
    cost = 8,
    pos = { x = 0, y = 1 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            repetitions = 1,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local other = context.other_card
            if not SideBets.scores(other) then return end

            local chosen = SideBets.analyse(context.scoring_hand).first_suit
            if not chosen[other] then return end

            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.repetitions,
                card = card,
            }
        end
    end,
}
