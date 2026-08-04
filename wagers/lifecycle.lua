local Wagers = SideBets.Wagers

local definitions = {}

function Wagers.define(def)
    assert(type(def.key) == "string" and def.key ~= "", "a wager needs a key")
    assert(type(def.check) == "function", ("wager %q needs a check function"):format(def.key))
    definitions[def.key] = def
end

function Wagers.get_definition(key)
    return definitions[key]
end

local function collect(status)
    local found = {}
    local state = Wagers.get_state()
    if not state then return found end

    for slot = 1, state.max_slots do
        local wager = state.slots[slot]
        if wager and wager.status == status then
            found[#found + 1] = wager
        end
    end
    return found
end

function Wagers.get_pending()
    return collect("pending")
end

function Wagers.get_active()
    return collect("active")
end

function Wagers.start_blind()
    local started = 0

    for _, wager in ipairs(Wagers.get_pending()) do
        local def = definitions[wager.key]
        wager.status = "active"
        wager.progress = def and def.new_progress and def.new_progress() or {}
        started = started + 1
    end

    return started
end

function Wagers.emit(name, data)
    local event = data or {}
    event.name = name

    for _, wager in ipairs(Wagers.get_active()) do
        local def = definitions[wager.key]
        if def and def.track then
            def.track(wager.progress, event)
        end
    end
end

function Wagers.resolve_blind(summary)
    for _, wager in ipairs(Wagers.get_active()) do
        local def = definitions[wager.key]
        local success = summary.won and def ~= nil and def.check(wager.progress, summary) == true

        wager.status = success and "success" or "failed"

        if def then
            local apply = success and def.reward or def.penalty
            if apply then apply(wager.progress, summary) end
        end
    end
end

function Wagers.cleanup_resolved()
    local state = Wagers.get_state()
    if not state then return end

    for slot = 1, state.max_slots do
        local wager = state.slots[slot]
        if wager and (wager.status == "success" or wager.status == "failed") then
            Wagers.remove(slot)
        end
    end
end
