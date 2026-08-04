local Wagers = SideBets.Wagers

local function place(area)
    area.T.x = G.consumeables.T.x
    area.T.y = G.consumeables.T.y + G.consumeables.T.h + 0.35
    area:hard_set_VT()
end

function Wagers.refresh_area()
    local area = G.sdb_wagers
    local state = Wagers.get_state()
    if not area or not state then return end

    area.config.card_limit = state.max_slots

    for i = #area.cards, 1, -1 do
        local card = area.cards[i]
        area:remove_card(card)
        card:remove()
    end

    for slot = 1, state.max_slots do
        local wager = state.slots[slot]
        if wager and G.P_CENTERS[wager.key] then
            area:emplace(SMODS.create_card {
                key = wager.key,
                area = area,
                skip_materialize = true,
            })
        end
    end
end

SMODS.current_mod.custom_card_areas = function(game)
    game.sdb_wagers = CardArea(0, 0, 2.3 * G.CARD_W, 0.95 * G.CARD_H, {
        card_limit = Wagers.get_max_slots(),
        type = "joker",
        highlight_limit = 0,
    })
    game.sdb_wagers.save = function() return nil end

    place(game.sdb_wagers)
    Wagers.refresh_area()
end
