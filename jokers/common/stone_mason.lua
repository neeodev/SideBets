SideBets.register_joker {
    id = "stone_mason",
    rarity = "Common",
    cost = 5,
    pos = { x = 1, y = 2 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            chips = 0,
            chip_gain = 8,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local extra = card.ability.extra
        return { vars = { extra.chip_gain, extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not SideBets.is_copy(context) then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.is_enhancement(other, "m_stone") then
                local counted = SideBets.hand_scratch(card)
                if not counted[other] then
                    counted[other] = true
                    local extra = card.ability.extra
                    extra.chips = extra.chips + extra.chip_gain
                    return {
                        extra = SideBets.upgrade_message(G.C.CHIPS),
                        colour = G.C.CHIPS,
                        card = card,
                    }
                end
            end
        end

        if context.joker_main then
            local chips = card.ability.extra.chips
            if chips > 0 then
                return { chips = chips }
            end
        end
    end,
}
