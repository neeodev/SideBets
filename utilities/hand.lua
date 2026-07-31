local STRAIGHTS = { "Straight", "Straight Flush" }

local ANALYSIS_OWNER = {}

function SideBets.numeric_rank_set(hand)
    local set, count = {}, 0
    for i = 1, #(hand or {}) do
        local id = SideBets.scoring_numeric_rank(hand[i])
        if id and not set[id] then
            set[id] = true
            count = count + 1
        end
    end
    return set, count
end

function SideBets.native_suit_set(hand, opts)
    opts = opts or {}
    local set, count = {}, 0
    for i = 1, #(hand or {}) do
        local card = hand[i]
        if SideBets.scores(card) and not (opts.ignore_wild and SideBets.is_wild(card)) then
            local suit = SideBets.native_suit(card)
            if suit and not set[suit] then
                set[suit] = true
                count = count + 1
            end
        end
    end
    return set, count
end

function SideBets.all_numeric(hand)
    local total = #(hand or {})
    if total == 0 then return false end
    for i = 1, total do
        local card = hand[i]
        if SideBets.scores(card) and not SideBets.numeric_rank(card) then
            return false
        end
    end
    return true
end

function SideBets.hand_has_straight(context)
    local hands = context and context.poker_hands
    if type(hands) ~= "table" then return false end
    for _, key in ipairs(STRAIGHTS) do
        local part = hands[key]
        if type(part) == "table" and next(part) ~= nil then return true end
    end
    return false
end

function SideBets.analyse(hand)
    local store = SideBets.hand_scratch(ANALYSIS_OWNER)
    if hand == nil then hand = {} end
    local cached = store[hand]
    if cached then return cached end

    local tally, first_suit, previous = {}, {}, {}
    local seen_suit, running = {}, {}

    for i = 1, #hand do
        local card = hand[i]
        if SideBets.scores(card) then
            local id = SideBets.rank_id(card)
            if id then tally[id] = (tally[id] or 0) + 1 end

            local suit = SideBets.native_suit(card)
            if suit and not seen_suit[suit] then
                seen_suit[suit] = true
                first_suit[card] = true
            end

            local num = SideBets.numeric_rank(card)
            if num then
                previous[card] = running[num] or 0
                running[num] = (running[num] or 0) + 1
            end
        end
    end

    cached = { tally = tally, first_suit = first_suit, previous = previous }
    store[hand] = cached
    return cached
end
