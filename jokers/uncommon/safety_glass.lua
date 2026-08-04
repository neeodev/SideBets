local KEY = "j_sdb_safety_glass"

local function find_saver()
    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.config.center.key == KEY
            and not joker.debuff
            and not joker.ability.extra.saved_this_round
        then
            return joker
        end
    end
end

function SideBets.save_glass_card(card)
    if not card or not card.glass_trigger then return false end

    local joker = find_saver()
    if not joker then return false end

    local extra = joker.ability.extra
    extra.saved_this_round = true
    extra.xmult = extra.xmult + extra.xmult_gain
    card.glass_trigger = nil

    SideBets.queue_card_message(card, localize("k_saved_ex"), G.C.CHIPS)
    return true
end

SideBets.register_joker {
    id = "safety_glass",
    rarity = "Uncommon",
    cost = 7,
    pos = { x = 2, y = 2 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 0.1,
            saved_this_round = false,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        local extra = card.ability.extra
        return { vars = { extra.xmult, extra.xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local xmult = card.ability.extra.xmult
            if xmult > 1 then
                return { x_mult = xmult }
            end
        end

        if context.end_of_round and not context.individual and not context.repetition
            and not SideBets.is_copy(context)
        then
            card.ability.extra.saved_this_round = false
        end
    end,
}
