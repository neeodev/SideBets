local Wagers = SideBets.Wagers

local function report(message)
    sendDebugMessage(message, "SideBets")
end

function Wagers.debug_add(key)
    if not Wagers.enabled() then
        report("wagers are disabled in the config")
        return nil
    end

    local slot = Wagers.add(key)
    if slot then
        report(("added %s in slot %d"):format(key, slot))
    else
        report("no free wager slot")
    end
    return slot
end

function Wagers.debug_clear()
    local state = Wagers.get_state()
    if not state then return end

    for slot in pairs(state.slots) do
        state.slots[slot] = nil
    end
    report("cleared every wager slot")
end

function Wagers.debug_print_state()
    local state = Wagers.get_state()
    if not state then
        report("no run in progress")
        return
    end

    report(("wagers %d/%d"):format(Wagers.count(), state.max_slots))
    for slot = 1, state.max_slots do
        local wager = state.slots[slot]
        report(("  slot %d: %s"):format(slot, wager and (wager.key .. " " .. wager.status) or "empty"))
    end
end
