local MIDDLE_RANKS = { [6] = true, [7] = true, [8] = true }

local function distinct_middle_ranks(hand)
    local seen, count = {}, 0
    for i = 1, #(hand or {}) do
        local card = hand[i]
        if SideBets.scores(card) then
            local id = SideBets.rank_id(card)
            if id and MIDDLE_RANKS[id] and not seen[id] then
                seen[id] = true
                count = count + 1
            end
        end
    end
    return count
end

SideBets.register_joker {
    id = "middle_child",
    rarity = "Common",
    cost = 4,
    pos = { x = 1, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            chips = 30,
            mult = 10,
            required_distinct_ranks = 2,
        },
    },

    loc_vars = function(self, info_queue, card)
        local extra = card.ability.extra
        return { vars = { extra.chips, extra.mult, extra.required_distinct_ranks } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.rank_in(other, MIDDLE_RANKS) then
                return { chips = card.ability.extra.chips }
            end
        end

        if context.joker_main then
            local extra = card.ability.extra
            if distinct_middle_ranks(context.scoring_hand) >= extra.required_distinct_ranks then
                return { mult = extra.mult }
            end
        end
    end,
}
