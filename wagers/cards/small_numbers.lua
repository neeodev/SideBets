local CHIPS = 5
local PENALTY = 4

local HIGH_RANKS = { [11] = true, [12] = true, [13] = true, [14] = true }

SideBets.register_wager {
    id = "small_numbers",
    pos = { x = 0, y = 0 },

    loc_vars = function()
        return { vars = { CHIPS, PENALTY } }
    end,

    new_progress = function()
        return { high_scored = false, winners = {} }
    end,

    track = function(progress, event)
        if event.name == "hand_played" then
            progress.winners = {}
        elseif event.name == "card_scored" and event.rank then
            if HIGH_RANKS[event.rank] then
                progress.high_scored = true
            else
                progress.winners[event.card_id] = true
            end
        end
    end,

    check = function(progress)
        return not progress.high_scored
    end,

    get_progress_text = function(progress)
        return progress.high_scored and "a high card scored" or "no high card scored"
    end,

    reward = function(progress)
        for _, card in ipairs(G.playing_cards or {}) do
            if progress.winners[card.sort_id] and card.ability then
                card.ability.perma_bonus = (card.ability.perma_bonus or 0) + CHIPS
                card:juice_up(0.3, 0.3)
            end
        end
    end,

    penalty = function()
        ease_dollars(-PENALTY)
    end,
}
