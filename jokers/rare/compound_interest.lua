SideBets.register_joker {
    id = "compound_interest",
    rarity = "Rare",
    cost = 9,
    pos = { x = 4, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1,
            gain_per_rank = 0.04,
            max_gain_per_round = 0.20,
            upgraded_this_round = false,
        },
    },

    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        return { vars = { extra.gain_per_rank, extra.max_gain_per_round, extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.before and not SideBets.is_copy(context) then
            local extra = card.ability.extra
            if extra.upgraded_this_round then return end

            local _, ranks = SideBets.numeric_rank_set(context.scoring_hand)
            if ranks <= 0 then return end

            extra.upgraded_this_round = true
            local gain = math.min(ranks * extra.gain_per_rank, extra.max_gain_per_round)
            extra.xmult = extra.xmult + gain

            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                card = card,
            }
        end

        if context.joker_main then
            local xmult = card.ability.extra.xmult
            if xmult > 1 then
                return { x_mult = xmult }
            end
        end

        if context.end_of_round and not context.individual and not context.repetition
            and not SideBets.is_copy(context)
        then
            card.ability.extra.upgraded_this_round = false
        end
    end,
}
