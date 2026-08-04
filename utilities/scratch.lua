local scratch = setmetatable({}, { __mode = "k" })

function SideBets.hand_scratch(key)
    local data = scratch[key]
    if not data then
        data = {}
        scratch[key] = data
    end
    return data
end

function SideBets.clear_hand_scratch()
    scratch = setmetatable({}, { __mode = "k" })
end

SideBets.on_calculate(function(context)
    local round_over = context.end_of_round and not context.individual and not context.repetition
    if context.before or round_over then
        SideBets.clear_hand_scratch()
    end
end)
