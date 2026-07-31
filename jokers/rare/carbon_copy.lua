SideBets.register_joker {
    id = "carbon_copy",
    rarity = "Rare",
    cost = 8,
    pos = { x = 5, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            repetitions = 1,
            required_occurrences = 2,
        },
    },

    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        return { vars = { extra.required_occurrences, extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local other = context.other_card
            if not SideBets.scores(other) then return end

            local rank = SideBets.rank_id(other)
            if not rank then return end

            local extra = card.ability.extra
            local tally = SideBets.analyse(context.scoring_hand).tally
            if tally[rank] ~= extra.required_occurrences then return end

            return {
                message = localize("k_again_ex"),
                repetitions = extra.repetitions,
                card = card,
            }
        end
    end,
}
