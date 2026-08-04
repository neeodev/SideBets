local listeners = {}

function SideBets.on_calculate(listener)
    listeners[#listeners + 1] = listener
end

SMODS.current_mod.calculate = function(self, context)
    for _, listener in ipairs(listeners) do
        local effect = listener(context)
        if effect then return effect end
    end
end
