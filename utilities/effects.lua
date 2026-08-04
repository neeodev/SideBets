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

