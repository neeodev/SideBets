local REWARD = 15
local PENALTY = 5
local MARGIN = 1.1

SideBets.register_wager {
    id = "exact_change",
    pos = { x = 1, y = 0 },

    loc_vars = function()
        return { vars = { math.floor((MARGIN - 1) * 100), REWARD, PENALTY } }
    end,

    check = function(_, summary)
        if not summary.score or not summary.requirement then return false end
        return to_big(summary.score) <= to_big(summary.requirement) * MARGIN
    end,

    get_progress_text = function()
        local blind = G.GAME and G.GAME.blind
        if not blind or not blind.chips then return nil end
        return ("stay under " .. number_format(blind.chips * MARGIN))
    end,

    reward = function()
        ease_dollars(REWARD)
    end,

    penalty = function()
        ease_dollars(-PENALTY)
    end,
}
