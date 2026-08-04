local Wagers = SideBets.Wagers

local GAP = 0.2
local SLOT_W = 1.15

local joker_w

function Wagers.layout()
    local area = G.sdb_wagers
    if not area or not G.jokers or not G.hand then return end

    joker_w = joker_w or G.jokers.T.w

    area.T.w = SLOT_W * G.CARD_W * Wagers.get_max_slots()
    area.T.x = G.hand.T.x - 0.1
    area.T.y = G.jokers.T.y

    local shift = area.T.w + GAP
    G.jokers.T.x = area.T.x + shift
    G.jokers.T.w = joker_w - shift

    area:hard_set_VT()
    G.jokers:hard_set_VT()
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
            local card = SMODS.create_card {
                key = wager.key,
                area = area,
                skip_materialize = true,
            }
            card.ability.wager_slot = slot
            area:emplace(card)
        end
    end
end

function Wagers.claim(card)
    local center = card.config and card.config.center
    local key = center and center.key

    if not key or not Wagers.get_definition(key) then return end
    if card.area == G.sdb_wagers then return end
    if not G.E_MANAGER then return end

    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            if card.area then card.area:remove_card(card) end
            card:remove()

            if not Wagers.add(key) then
                sendDebugMessage(("no free slot for %s, the card was discarded"):format(key), "SideBets")
            end
            return true
        end,
    }))
end

local function is_wager_card(card)
    return G.sdb_wagers and card and card.area == G.sdb_wagers
end

local card_focus_ui = G.UIDEF.card_focus_ui

G.UIDEF.card_focus_ui = function(card)
    local ui = card_focus_ui(card)

    if is_wager_card(card) and G.STATE ~= G.STATES.TUTORIAL then
        local attach = ui:get_UIE_by_ID("ATTACH_TO_ME")
        attach.children.sell = G.UIDEF.card_focus_button {
            card = card,
            parent = attach,
            type = "sell",
            func = "can_sell_card",
            button = "sell_card",
            card_width = card.T.w - 0.1,
        }
    end

    return ui
end

local sell_card = G.FUNCS.sell_card

G.FUNCS.sell_card = function(e)
    local card = e and e.config and e.config.ref_table
    local slot = is_wager_card(card) and card.ability.wager_slot or nil

    sell_card(e)

    if slot then
        local state = Wagers.get_state()
        if state then state.slots[slot] = nil end
    end
end

SMODS.current_mod.custom_card_areas = function(game)
    if not Wagers.enabled() then return end

    game.sdb_wagers = CardArea(0, 0, SLOT_W * G.CARD_W, 0.95 * G.CARD_H, {
        card_limit = Wagers.get_max_slots(),
        type = "joker",
        highlight_limit = 1,
        align_buttons = true,
    })
    game.sdb_wagers.save = function() return nil end

    Wagers.layout()
    Wagers.refresh_area()
end
