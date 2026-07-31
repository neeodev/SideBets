local function hand_counts(card, context)
    local source = SideBets.effect_source(card, context)
    local scratch = SideBets.hand_scratch(source)
    scratch.long_division = scratch.long_division or {}
    return scratch.long_division
end

SideBets.register_joker {
    id = "long_division",
    rarity = "Legendary",
    cost = 20,
    pos = { x = 5, y = 2 },
    soul_pos = { x = 0, y = 0 },
    soul_atlas = "jokers_soul",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {
        extra = {
            step = 0.03,
        },
    },

    loc_vars = function(self, info_queue, card)
        local step = card.ability.extra.step
        return { vars = { step, 1 + step } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            local rank = SideBets.scoring_numeric_rank(other)
            if not rank then return end

            local counts = hand_counts(card, context)
            local n = (counts[rank] or 0) + 1
            counts[rank] = n

            return { x_mult = 1 + n * card.ability.extra.step }
        end
    end,
}
