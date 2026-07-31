local PROB_SEED = "sdb_second_coat"

local function find_candidate(hand)
    for i = 1, #(hand or {}) do
        local card = hand[i]
        if SideBets.scores(card)
            and not SideBets.is_destroyed(card)
            and SideBets.has_enhancement(card)
            and not SideBets.has_edition(card)
        then
            return card
        end
    end
    return nil
end

SideBets.register_joker {
    id = "second_coat",
    rarity = "Uncommon",
    cost = 6,
    pos = { x = 4, y = 1 },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            odds = 4,
            attempted_this_round = false,
        },
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        local extra = card.ability.extra
        local numerator, denominator = SideBets.odds_vars(card, 1, extra.odds, PROB_SEED)
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.after and not SideBets.is_copy(context) then
            local extra = card.ability.extra
            if extra.attempted_this_round then return end

            local target = find_candidate(context.scoring_hand)
            if not target then return end

            extra.attempted_this_round = true

            if SideBets.roll(card, PROB_SEED, 1, extra.odds) then
                target:set_edition("e_foil", true)
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.DARK_EDITION,
                    card = card,
                }
            end

            return {
                message = localize("k_nope_ex"),
                colour = G.C.UI.TEXT_INACTIVE,
                card = card,
            }
        end

        if context.end_of_round and not context.individual and not context.repetition
            and not SideBets.is_copy(context)
        then
            card.ability.extra.attempted_this_round = false
        end
    end,
}
