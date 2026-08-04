local UPGRADES = 2

SideBets.register_wager {
    id = "last_hand_standing",
    pos = { x = 4, y = 0 },

    loc_vars = function()
        return { vars = { UPGRADES } }
    end,

    check = function(_, summary)
        return summary.hands_left == 0
    end,

    get_progress_text = function()
        local round = G.GAME and G.GAME.current_round
        if not round then return nil end
        return ("%d hand(s) left"):format(round.hands_left or 0)
    end,

    reward = function()
        local plain = {}
        for _, card in ipairs(G.playing_cards or {}) do
            if not SideBets.has_enhancement(card) then plain[#plain + 1] = card end
        end

        for i = 1, UPGRADES do
            if #plain == 0 then return end

            local card = table.remove(plain, pseudorandom(pseudoseed("sdb_lhs" .. i), 1, #plain))
            local enhancement = SMODS.poll_enhancement { guaranteed = true, key = "sdb_lhs_kind" .. i }

            if enhancement then
                card:set_ability(G.P_CENTERS[enhancement], true)
                card:juice_up(0.3, 0.3)
            end
        end
    end,

    penalty = function()
        local bonus = G.GAME.round_bonus
        bonus.next_hands = (bonus.next_hands or 0) - 1
    end,
}
