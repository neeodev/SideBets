local COUNTERFEIT_SEALS = {
    [SideBets.SEAL_BLUE] = true,
    [SideBets.SEAL_GOLD] = true,
    [SideBets.SEAL_PURPLE] = true,
}

SideBets.register_joker {
    id = "counterfeit_seal",
    rarity = "Rare",
    cost = 8,
    pos = { x = 5, y = 1 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            repetitions = 1,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "blue_seal", set = "Other" }
        info_queue[#info_queue + 1] = { key = "gold_seal", set = "Other" }
        info_queue[#info_queue + 1] = { key = "purple_seal", set = "Other" }
        return { vars = { card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local other = context.other_card
            if not SideBets.scores(other) then return end
            if not SideBets.seal_in(other, COUNTERFEIT_SEALS) then return end

            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.repetitions,
                card = card,
            }
        end
    end,
}
