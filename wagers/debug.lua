local Wagers = SideBets.Wagers

local function report(message)
    sendDebugMessage(message, "SideBets")
end

local function count_keys(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

SideBets.register_wager {
    id = "test",
    pos = { x = 0, y = 0 },
    no_collection = true,
    in_pool = function() return false end,
    new_progress = function()
        return { cards = {}, discarded = false }
    end,
    track = function(progress, event)
        if event.name == "card_scored" and event.card_id then
            progress.cards[event.card_id] = true
        elseif event.name == "discard_used" then
            progress.discarded = true
        end
    end,
    check = function(progress)
        return count_keys(progress.cards) >= 3 and not progress.discarded
    end,
    get_progress_text = function(progress)
        return ("%d/3 cards, %s"):format(
            count_keys(progress.cards),
            progress.discarded and "discard used" or "no discard")
    end,
    reward = function()
        report("test wager paid out")
    end,
    penalty = function()
        report("test wager lost")
    end,
}

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
    Wagers.refresh_area()
    report("cleared every wager slot")
end

function Wagers.debug_start()
    report(("activated %d wager(s)"):format(Wagers.start_blind()))
end

local function resolve(won)
    Wagers.resolve_blind(Wagers.blind_summary(won))
    Wagers.cleanup_resolved()
    report(won and "resolved as a win" or "resolved as a loss")
end

function Wagers.debug_resolve_success()
    resolve(true)
end

function Wagers.debug_resolve_failure()
    resolve(false)
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
        if not wager then
            report(("  slot %d: empty"):format(slot))
        else
            local def = Wagers.get_definition(wager.key)
            local progress = wager.progress and def and def.get_progress_text
                and def.get_progress_text(wager.progress)

            report(("  slot %d: %s %s%s"):format(slot, wager.key, wager.status,
                progress and (" [" .. progress .. "]") or ""))
        end
    end
end
