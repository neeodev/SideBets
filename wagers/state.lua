SideBets.Wagers = {}

local Wagers = SideBets.Wagers

Wagers.DEFAULT_SLOTS = 1

function Wagers.refresh_area() end

function Wagers.enabled()
    local cfg = SideBets.config and SideBets.config.wagers
    return not cfg or cfg.enabled ~= false
end

function Wagers.card_enabled(id)
    local cfg = SideBets.config and SideBets.config.wagers
    local cards = cfg and cfg.cards
    return not cards or cards[id] ~= false
end

function Wagers.get_state()
    if not G.GAME then return nil end
    G.GAME.sidebets = G.GAME.sidebets or {}
    G.GAME.sidebets.wagers = G.GAME.sidebets.wagers or {
        max_slots = Wagers.DEFAULT_SLOTS,
        slots = {},
    }
    return G.GAME.sidebets.wagers
end

function Wagers.get_max_slots()
    local state = Wagers.get_state()
    return state and state.max_slots or Wagers.DEFAULT_SLOTS
end

function Wagers.get(slot)
    local state = Wagers.get_state()
    return state and state.slots[slot] or nil
end

function Wagers.count()
    local state = Wagers.get_state()
    if not state then return 0 end

    local filled = 0
    for slot = 1, state.max_slots do
        if state.slots[slot] then filled = filled + 1 end
    end
    return filled
end

function Wagers.free_slot()
    local state = Wagers.get_state()
    if not state then return nil end

    for slot = 1, state.max_slots do
        if not state.slots[slot] then return slot end
    end
    return nil
end

function Wagers.has_free_slot()
    return Wagers.free_slot() ~= nil
end

function Wagers.add(key)
    local state = Wagers.get_state()
    if not state then return nil end

    local slot = Wagers.free_slot()
    if not slot then return nil end

    state.slots[slot] = { key = key, status = "pending" }
    Wagers.refresh_area()
    return slot
end

function Wagers.replace(slot, key)
    local state = Wagers.get_state()
    if not state or slot < 1 or slot > state.max_slots then return false end

    local current = state.slots[slot]
    if current and current.status ~= "pending" then return false end

    state.slots[slot] = { key = key, status = "pending" }
    Wagers.refresh_area()
    return true
end

function Wagers.remove(slot)
    local state = Wagers.get_state()
    if not state or not state.slots[slot] then return false end

    state.slots[slot] = nil
    Wagers.refresh_area()
    return true
end
