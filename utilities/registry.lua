function SideBets.enabled(id)
    local cfg = SideBets.config
    if not cfg then return true end
    if SideBets.ENDLESS_ASCENSION[id] and cfg.enable_endless_ascension == false then
        return false
    end
    return not cfg.jokers or cfg.jokers[id] ~= false
end

function SideBets.register_joker(def)
    local id = def.id
    assert(type(id) == "string" and id ~= "", "SideBets Joker is missing its `id`")
    assert(type(def.pos) == "table", ("SideBets Joker %q is missing its atlas `pos`"):format(id))

    def.id = nil
    def.key = id
    def.atlas = def.atlas or "jokers"

    local extra_in_pool = def.in_pool
    def.in_pool = function(self, args)
        if not SideBets.enabled(id) then return false end
        if extra_in_pool then return extra_in_pool(self, args) end
        return true
    end

    return SMODS.Joker(def)
end
