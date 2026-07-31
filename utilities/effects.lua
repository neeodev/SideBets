function SideBets.is_copy(context)
    return context ~= nil and context.blueprint ~= nil
end

function SideBets.effect_source(card, context)
    return (context and context.blueprint_card) or card
end

function SideBets.roll(card, seed, numerator, denominator)
    return SMODS.pseudorandom_probability(card, seed, numerator, denominator, seed)
end

function SideBets.odds_vars(card, numerator, denominator, seed)
    if not card or not G.GAME then return numerator, denominator end
    return SMODS.get_probability_vars(card, numerator, denominator, seed)
end

function SideBets.upgrade_message(colour)
    return { message = localize("k_upgrade_ex"), colour = colour or G.C.MULT }
end

function SideBets.queue_card_message(card, message, colour)
    if not card or not G.E_MANAGER then return end
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            if not SideBets.is_destroyed(card) then
                card:juice_up(0.3, 0.3)
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = message,
                    colour = colour or G.C.CHIPS,
                })
            end
            return true
        end,
    }))
end
