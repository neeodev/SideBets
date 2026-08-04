local Wagers = SideBets.Wagers

function Wagers.blind_summary(won, scoring_name)
    local round = G.GAME and G.GAME.current_round

    return {
        won = won,
        scoring_name = scoring_name,
        score = G.GAME and G.GAME.chips,
        requirement = G.GAME and G.GAME.blind and G.GAME.blind.chips,
        hands_left = round and round.hands_left,
        discards_left = round and round.discards_left,
    }
end

local function is_blind_result(context)
    return context.end_of_round
        and not context.cardarea
        and not context.individual
        and not context.repetition
end

SideBets.on_calculate(function(context)
    if not Wagers.enabled() then return end

    if context.setting_blind then
        Wagers.start_blind()
    elseif context.before then
        Wagers.emit("hand_played", { scoring_name = context.scoring_name })
    elseif context.pre_discard then
        Wagers.emit("discard_used")
    elseif context.individual and context.cardarea == G.play then
        local card = context.other_card
        if SideBets.scores(card) then
            Wagers.emit("card_scored", {
                card_id = card.sort_id,
                rank = SideBets.rank_id(card),
                suit = SideBets.native_suit(card),
            })
        end
    elseif is_blind_result(context) then
        Wagers.resolve_blind(Wagers.blind_summary(not context.game_over, context.scoring_name))
        Wagers.cleanup_resolved()
    end
end)
