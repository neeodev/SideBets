local Wagers = SideBets.Wagers

local BEHAVIOUR = { "new_progress", "track", "check", "get_progress_text", "reward", "penalty" }

SMODS.ConsumableType {
    key = "Wager",
    primary_colour = SideBets.badge_colour,
    secondary_colour = HEX("2A4E66"),
    collection_rows = { 5, 5 },
    select_card = "sdb_wagers",
    loc_txt = {
        name = "Wager",
        collection = "Wagers",
        undiscovered = {
            name = "Undiscovered Wager",
            text = { "Take this Wager in an", "unseen run to learn", "what it does" },
        },
    },
}

function SideBets.register_wager(def)
    local id = def.id
    assert(type(id) == "string" and id ~= "", "a wager is missing its `id`")
    assert(type(def.pos) == "table", ("wager %q is missing its atlas `pos`"):format(id))

    local behaviour = { key = "c_sdb_" .. id }
    for _, field in ipairs(BEHAVIOUR) do
        behaviour[field] = def[field]
        def[field] = nil
    end
    Wagers.define(behaviour)

    def.id = nil
    def.key = id
    def.set = "Wager"
    def.atlas = def.atlas or "wagers"
    def.can_use = function() return false end

    local extra_in_pool = def.in_pool
    def.in_pool = function(self, args)
        if not Wagers.enabled() then return false end
        if extra_in_pool then return extra_in_pool(self, args) end
        return true
    end

    return SMODS.Consumable(def)
end
