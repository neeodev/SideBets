local SUITS = { "Spades", "Hearts", "Clubs", "Diamonds" }
local EDITIONS = { "e_foil", "e_holo", "e_polychrome" }

local function pick(candidates, seed)
    if #candidates == 0 then return nil end
    return candidates[pseudorandom(pseudoseed(seed), 1, #candidates)]
end

SideBets.register_wager {
    id = "full_spectrum",
    pos = { x = 2, y = 0 },

    new_progress = function()
        return { suits = {}, scored = {} }
    end,

    track = function(progress, event)
        if event.name ~= "card_scored" then return end

        progress.scored[event.card_id] = true

        if event.wild then
            for _, suit in ipairs(SUITS) do progress.suits[suit] = true end
        elseif event.suit then
            progress.suits[event.suit] = true
        end
    end,

    check = function(progress)
        for _, suit in ipairs(SUITS) do
            if not progress.suits[suit] then return false end
        end
        return true
    end,

    get_progress_text = function(progress)
        local found = {}
        for _, suit in ipairs(SUITS) do
            found[#found + 1] = suit:sub(1, 1) .. (progress.suits[suit] and "+" or "-")
        end
        return table.concat(found, " ")
    end,

    reward = function(progress)
        local scored = {}
        for _, card in ipairs(G.playing_cards or {}) do
            if progress.scored[card.sort_id] then scored[#scored + 1] = card end
        end

        local card = pick(scored, "sdb_spectrum")
        if card then
            card:set_edition(pick(EDITIONS, "sdb_spectrum_edition"), true)
        end
    end,

    penalty = function()
        local edited = {}
        for _, card in ipairs(G.playing_cards or {}) do
            if SideBets.has_edition(card) then edited[#edited + 1] = card end
        end

        local card = pick(edited, "sdb_spectrum_strip")
        if card then card:set_edition(nil, true) end
    end,
}
