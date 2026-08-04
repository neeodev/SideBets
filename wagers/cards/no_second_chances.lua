SideBets.register_wager {
    id = "no_second_chances",
    pos = { x = 3, y = 0 },

    new_progress = function()
        return { discarded = false }
    end,

    track = function(progress, event)
        if event.name == "discard_used" then progress.discarded = true end
    end,

    check = function(progress)
        return not progress.discarded
    end,

    get_progress_text = function(progress)
        return progress.discarded and "discard used" or "no discard used"
    end,

    reward = function()
        local bonus = G.GAME.round_bonus
        bonus.next_hands = (bonus.next_hands or 0) + 1

        if #G.consumeables.cards < G.consumeables.config.card_limit then
            SMODS.add_card { set = "Tarot" }
        end
    end,

    penalty = function()
        local bonus = G.GAME.round_bonus
        bonus.discards = (bonus.discards or 0) - 1
    end,
}
