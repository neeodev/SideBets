SideBets.MIN_NUMERIC_RANK = 2
SideBets.MAX_NUMERIC_RANK = 10

SideBets.NUMERIC_RANK_COUNT = SideBets.MAX_NUMERIC_RANK - SideBets.MIN_NUMERIC_RANK + 1

SideBets.SEAL_BLUE = "Blue"
SideBets.SEAL_GOLD = "Gold"
SideBets.SEAL_PURPLE = "Purple"

function SideBets.scores(card)
    return card ~= nil and not card.debuff
end

function SideBets.is_destroyed(card)
    if not card then return true end
    return card.destroyed or card.shattered or card.getting_sliced or card.removed_from_deck
end

function SideBets.rank_id(card)
    if not card or not card.base then return nil end
    if SMODS.has_no_rank(card) then return nil end
    return card.base.id
end

function SideBets.numeric_rank(card)
    local id = SideBets.rank_id(card)
    if not id then return nil end
    if id < SideBets.MIN_NUMERIC_RANK or id > SideBets.MAX_NUMERIC_RANK then return nil end
    return id
end

function SideBets.scoring_numeric_rank(card)
    if not SideBets.scores(card) then return nil end
    return SideBets.numeric_rank(card)
end

function SideBets.rank_in(card, ranks)
    local id = SideBets.rank_id(card)
    return id and ranks[id]
end

function SideBets.native_suit(card)
    if not card or not card.base then return nil end
    if SMODS.has_no_suit(card) then return nil end
    return card.base.suit
end

function SideBets.has_enhancement(card)
    return card ~= nil and next(SMODS.get_enhancements(card)) ~= nil
end

function SideBets.is_enhancement(card, key)
    return card and SMODS.has_enhancement(card, key)
end

function SideBets.has_edition(card)
    local edition = card and card.edition
    return edition ~= nil and edition.key ~= "e_base"
end

function SideBets.has_seal(card)
    return card ~= nil and card.seal ~= nil
end

function SideBets.seal_in(card, seals)
    return SideBets.has_seal(card) and seals[card.seal]
end

function SideBets.is_plain(card)
    return not SideBets.has_enhancement(card)
        and not SideBets.has_seal(card)
        and not SideBets.has_edition(card)
end

function SideBets.add_perma_bonus(card, amount)
    if not card or not card.ability then return end
    card.ability.perma_bonus = (card.ability.perma_bonus or 0) + amount
end
