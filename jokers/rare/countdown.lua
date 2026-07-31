SideBets.register_joker {
    id = "countdown",
    rarity = "Rare",
    cost = 9,
    pos = { x = 3, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            repetitions = 1,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local other = context.other_card
            if not SideBets.scores(other) then return end
            if not SideBets.numeric_rank(other) then return end
            if not SideBets.hand_has_straight(context) then return end
            if not SideBets.all_numeric(context.scoring_hand) then return end

            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.repetitions,
                card = card,
            }
        end
    end,
}
