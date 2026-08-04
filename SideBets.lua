SideBets = {}

SideBets.config = SMODS.current_mod.config
SideBets.badge_colour = HEX("3B6E8F")

SideBets.ENDLESS_ASCENSION = {
    decimal_engine = true,
    echo_chamber = true,
    long_division = true,
}

SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "wagers",
    path = "wagers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "jokers_soul",
    path = "jokers_soul.png",
    px = 71,
    py = 95,
}

local SYSTEM = {
    "utilities/calculate.lua",
    "utilities/card.lua",
    "utilities/hand.lua",
    "utilities/scratch.lua",
    "utilities/effects.lua",
    "utilities/registry.lua",

    "wagers/state.lua",
    "wagers/lifecycle.lua",
    "wagers/events.lua",
    "wagers/registry.lua",
    "wagers/area.lua",
    "wagers/debug.lua",
}

for _, path in ipairs(SYSTEM) do
    assert(SMODS.load_file(path))()
end

local JOKERS = {
    "common/prime_time",
    "common/middle_child",
    "common/house_edge",
    "common/stone_mason",

    "uncommon/keep_your_distance",
    "uncommon/patchwork",
    "uncommon/blank_slate",
    "uncommon/collectors_grade",
    "uncommon/second_coat",
    "uncommon/safety_glass",

    "rare/countdown",
    "rare/compound_interest",
    "rare/carbon_copy",
    "rare/color_theory",
    "rare/counterfeit_seal",
    "rare/decimal_engine",
    "rare/echo_chamber",

    "legendary/long_division",
}

local JOKER_IDS = {}

local WAGERS = {
    "small_numbers",
    "exact_change",
    "full_spectrum",
    "no_second_chances",
    "last_hand_standing",
}

for _, name in ipairs(WAGERS) do
    assert(SMODS.load_file("wagers/cards/" .. name .. ".lua"))()
end

for _, name in ipairs(JOKERS) do
    assert(SMODS.load_file("jokers/" .. name .. ".lua"))()
    JOKER_IDS[#JOKER_IDS + 1] = name:match("[^/]+$")
end

local function toggle_row(id)
    return create_toggle {
        label = localize { type = "name_text", set = "Joker", key = "j_sdb_" .. id },
        active_colour = SideBets.badge_colour,
        ref_table = SideBets.config.jokers,
        ref_value = id,
        w = 0,
        scale = 0.75,
        label_scale = 0.36,
    }
end

local function toggle_column(first, last)
    local nodes = {}
    for i = first, math.min(last, #JOKER_IDS) do
        nodes[#nodes + 1] = { n = G.UIT.R, config = { align = "cl", padding = 0.03 },
            nodes = { toggle_row(JOKER_IDS[i]) } }
    end
    return { n = G.UIT.C, config = { align = "tl", minw = G.ROOM.T.w * 0.19, padding = 0.04 }, nodes = nodes }
end

SMODS.current_mod.config_tab = function()
    local per_column = math.ceil(#JOKER_IDS / 3)

    return {
        n = G.UIT.ROOT,
        config = { align = "tm", minh = G.ROOM.T.h * 0.25, padding = 0.05, r = 0.1, colour = G.C.CLEAR },
        nodes = {
            { n = G.UIT.R, config = { align = "cm", padding = 0.04 }, nodes = {
                { n = G.UIT.T, config = { text = localize("sdb_config_jokers"), scale = 0.42, colour = G.C.WHITE } },
            } },
            { n = G.UIT.R, config = { align = "cm", padding = 0.02 }, nodes = {
                toggle_column(1, per_column),
                toggle_column(per_column + 1, per_column * 2),
                toggle_column(per_column * 2 + 1, per_column * 3),
            } },
            { n = G.UIT.R, config = { align = "cm", padding = 0.06 }, nodes = { create_toggle {
                label = localize("sdb_config_endless"),
                info = { localize("sdb_config_endless_desc") },
                active_colour = SideBets.badge_colour,
                ref_table = SideBets.config,
                ref_value = "enable_endless_ascension",
                w = 0,
                scale = 0.75,
                label_scale = 0.36,
            } } },
            { n = G.UIT.R, config = { align = "cm", padding = 0.04 }, nodes = {
                { n = G.UIT.T, config = { text = localize("sdb_config_note"), scale = 0.3, colour = G.C.UI.TEXT_INACTIVE } },
            } },
        },
    }
end
