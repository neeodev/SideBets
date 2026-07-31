SideBets.register_joker {
    id = "echo_chamber",
    rarity = "Rare",
    cost = 9,
    pos = { x = 4, y = 2 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            max_repetitions = 4,
        },
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local other = context.other_card
            if not SideBets.scores(other) then return end
            if not SideBets.numeric_rank(other) then return end

            local previous = SideBets.analyse(context.scoring_hand).previous[other] or 0
            if previous <= 0 then return end

            return {
                message = localize("k_again_ex"),
                repetitions = math.min(previous, card.ability.extra.max_repetitions),
                card = card,
            }
        end
    end,
}
