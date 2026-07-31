SideBets.register_joker {
    id = "safety_glass",
    rarity = "Uncommon",
    cost = 7,
    pos = { x = 2, y = 2 },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            permanent_chip_gain = 4,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.permanent_chip_gain } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not SideBets.is_copy(context) then
            local other = context.other_card
            if SideBets.scores(other) and SideBets.is_enhancement(other, "m_glass") then
                local pending = SideBets.hand_scratch(card)
                pending[other] = true
            end
            return
        end

        if context.after and not SideBets.is_copy(context) then
            local pending = SideBets.hand_scratch(card)
            local gain = card.ability.extra.permanent_chip_gain
            local upgraded = 0

            for glass_card in pairs(pending) do
                pending[glass_card] = nil

                if not SideBets.is_destroyed(glass_card) then
                    SideBets.add_perma_bonus(glass_card, gain)
                    upgraded = upgraded + 1
                    SideBets.queue_card_message(glass_card, localize("k_upgrade_ex"), G.C.CHIPS)
                end
            end

            if upgraded > 0 then
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS,
                    card = card,
                }
            end
        end
    end,
}
