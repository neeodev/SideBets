return {
    descriptions = {
        Joker = {
            j_sdb_prime_time = {
                name = "Prime Time",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if a {C:attention}prime{} number",
                    "of cards score",
                    "{C:inactive}(2, 3 or 5 cards){}",
                },
            },
            j_sdb_middle_child = {
                name = "Middle Child",
                text = {
                    "Scored {C:attention}6s{}, {C:attention}7s{} and {C:attention}8s{}",
                    "give {C:chips}+#1#{} Chips",
                    "If {C:attention}#3#{} different ranks among them",
                    "are scored, also {C:mult}+#2#{} Mult",
                },
            },
            j_sdb_house_edge = {
                name = "House Edge",
                text = {
                    "Each scored {C:attention}Lucky Card{}",
                    "always gives {X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}(Does not change their odds){}",
                },
            },
            j_sdb_stone_mason = {
                name = "Stone Mason",
                text = {
                    "Gains {C:chips}+#1#{} Chips permanently",
                    "when a {C:attention}Stone Card{} scores",
                    "{C:inactive}(Currently {C:chips}+#2#{} {C:inactive}Chips){}",
                },
            },

            j_sdb_keep_your_distance = {
                name = "Keep Your Distance",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if {C:attention}#3#{}+ scored cards",
                    "are all {C:attention}numbered{} and no two",
                    "ranks used are under {C:attention}#2#{} apart",
                    "{C:inactive}(2+ ranks, repeats allowed){}",
                },
            },
            j_sdb_patchwork = {
                name = "Patchwork",
                text = {
                    "The {C:attention}first{} scored card",
                    "of each {C:attention}suit{} retriggers",
                    "{C:attention}#1#{} additional time",
                },
            },
            j_sdb_blank_slate = {
                name = "Blank Slate",
                text = {
                    "Each scored card with no",
                    "{C:attention}enhancement{}, {C:attention}seal{} or {C:attention}edition{}",
                    "gives {X:mult,C:white}X#1#{} Mult",
                },
            },
            j_sdb_collectors_grade = {
                name = "Collector's Grade",
                text = {
                    "Scored cards with",
                    "an {C:attention}Enhancement{}, {C:attention}Edition{}",
                    "and {C:attention}Seal{} give",
                    "{X:mult,C:white}X#1#{} Mult",
                },
            },
            j_sdb_second_coat = {
                name = "Second Coat",
                text = {
                    "{C:green}#1# in #2#{} chance for the first",
                    "scored card with an {C:attention}enhancement{}",
                    "and no edition to become {C:dark_edition}Foil{}",
                    "{C:inactive}(Once per round){}",
                },
            },
            j_sdb_safety_glass = {
                name = "Safety Glass",
                text = {
                    "Each scored {C:attention}Glass Card{} that",
                    "is not destroyed permanently",
                    "gains {C:chips}+#1#{} Bonus Chips",
                },
            },

            j_sdb_countdown = {
                name = "Countdown",
                text = {
                    "Retriggers each scored card",
                    "{C:attention}#1#{} extra time if the hand is",
                    "a {C:attention}Straight{} made only of",
                    "cards from {C:attention}2{} to {C:attention}10{}",
                },
            },
            j_sdb_compound_interest = {
                name = "Compound Interest",
                text = {
                    "On the {C:attention}first hand{} of each round,",
                    "permanently gains {X:mult,C:white}X#1#{} Mult per",
                    "different rank from {C:attention}2{} to {C:attention}10{} scored",
                    "{C:inactive}(Max {X:mult,C:white}X#2#{} {C:inactive}per round){}",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}Mult){}",
                },
            },
            j_sdb_carbon_copy = {
                name = "Carbon Copy",
                text = {
                    "Retriggers each scored card",
                    "whose rank appears exactly",
                    "{C:attention}#1#{} times in the scored hand",
                    "{C:inactive}(#2# extra trigger each){}",
                },
            },
            j_sdb_color_theory = {
                name = "Color Theory",
                text = {
                    "Retriggers the {C:attention}first{} scored",
                    "card of each {C:attention}suit{} #1# extra time",
                    "{C:inactive}({C:attention}Wild Cards{} {C:inactive}use only",
                    "{C:inactive}their printed suit){}",
                },
            },
            j_sdb_counterfeit_seal = {
                name = "Counterfeit Seal",
                text = {
                    "Retriggers each scored card",
                    "with a {C:blue}Blue{}, {C:money}Gold{} or {C:purple}Purple{}",
                    "Seal #1# extra time",
                    "{C:inactive}({C:red}Red Seals{} {C:inactive}excluded){}",
                },
            },

            j_sdb_decimal_engine = {
                name = "Decimal Engine",
                text = {
                    "Scored numbered cards give",
                    "{X:mult,C:white}X#1#{} Mult",
                    "After every rank from {C:attention}2{} to {C:attention}10{}",
                    "scores during a round, multiply",
                    "this value by {X:mult,C:white}X#2#{}",
                    "{C:inactive}(Once per round){}",
                },
            },
            j_sdb_echo_chamber = {
                name = "Echo Chamber",
                text = {
                    "Scored numbered cards retrigger",
                    "once for each previous scored",
                    "card of the {C:attention}same rank{}",
                    "{C:inactive}(Max #1# per card){}",
                },
            },
            j_sdb_long_division = {
                name = "Long Division",
                text = {
                    "Scored numbered cards give",
                    "increasing {X:mult,C:white}XMult{} for each",
                    "trigger of the {C:attention}same rank{}",
                    "Starts at {X:mult,C:white}X#2#{} and",
                    "increases by {X:mult,C:white}X#1#{}",
                    "{C:inactive}(Resets after each hand){}",
                },
            },
        },
    },
    misc = {
        dictionary = {
            sdb_config_jokers = "Available Jokers",
            sdb_config_endless = "Endless Ascension Jokers",
            sdb_config_endless_desc = "Decimal Engine, Echo Chamber, Long Division",
            sdb_config_note = "Disabling a Joker only stops it from appearing. Jokers already owned keep working.",
        },
    },
}
