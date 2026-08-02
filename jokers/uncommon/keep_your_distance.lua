local function ranks_are_spread(hand, min_distance)
    local used, count = SideBets.numeric_rank_set(hand)
    if count < 2 then return false end

    local previous

    for rank = SideBets.MIN_NUMERIC_RANK, SideBets.MAX_NUMERIC_RANK do
        if used[rank] then
            if previous and rank - previous < min_distance then return false end
            previous = rank
        end
    end

    return true
end

SideBets.register_joker {
    id = "keep_your_distance",
    rarity = "Uncommon",
    cost = 6,
    pos = { x = 2, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 2,
            min_distance = 3,
            required_cards = 4,
        },
    },

    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        return { vars = { extra.xmult, extra.min_distance, extra.required_cards } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local extra = card.ability.extra
            local hand = context.scoring_hand

            if #hand >= extra.required_cards
                and SideBets.all_numeric(hand)
                and ranks_are_spread(hand, extra.min_distance)
            then
                return { x_mult = extra.xmult }
            end
        end
    end,
}
