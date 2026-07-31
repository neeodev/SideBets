local function seen_count(extra)
    local count = 0
    for _ in pairs(extra.seen_ranks) do count = count + 1 end
    return count
end

SideBets.register_joker {
    id = "decimal_engine",
    rarity = "Rare",
    cost = 9,
    pos = { x = 3, y = 2 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1,
            growth_factor = 1.08,
            seen_ranks = {},
            cycled_this_round = false,
        },
    },

    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        return { vars = { extra.xmult, extra.growth_factor } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            local rank = SideBets.scoring_numeric_rank(other)
            if not rank then return end

            local extra = card.ability.extra
            local upgraded = false

            if not SideBets.is_copy(context) and not extra.cycled_this_round then
                extra.seen_ranks[rank] = true

                if seen_count(extra) >= SideBets.NUMERIC_RANK_COUNT then
                    extra.xmult = extra.xmult * extra.growth_factor
                    extra.seen_ranks = {}
                    extra.cycled_this_round = true
                    upgraded = true
                end
            end

            if extra.xmult <= 1 then return end

            if upgraded then
                return {
                    x_mult = extra.xmult,
                    extra = SideBets.upgrade_message(G.C.MULT),
                    card = card,
                }
            end

            return { x_mult = extra.xmult }
        end

        if context.end_of_round and not context.individual and not context.repetition
            and not SideBets.is_copy(context)
        then
            local extra = card.ability.extra
            extra.seen_ranks = {}
            extra.cycled_this_round = false
        end
    end,
}
