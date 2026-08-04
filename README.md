# Side Bets

A Balatro mod with 18 Jokers built around numbered cards, alternative hand
shapes and the card modifiers vanilla mostly leaves alone.

## Install

Requires Lovely Injector and Steamodded `1.0.0~BETA-0624a` or newer. Drop the
`SideBets` folder into your Balatro `Mods` folder:

- macOS: `~/Library/Application Support/Balatro/Mods/`
- Windows: `%AppData%\Balatro\Mods\`

Talisman is worth having if you push Endless far, since Decimal Engine and Long
Division keep scaling.

## Jokers

### Common

| Joker | Cost | Effect |
|---|---:|---|
| Prime Time | $4 | X1.5 Mult if a prime number of cards score, so 2, 3 or 5 of them |
| Middle Child | $4 | Scored 6s, 7s and 8s give +30 Chips. If at least two different ranks among them score, also gives +10 Mult |
| House Edge | $5 | Each scored Lucky Card gives a guaranteed X1.10 Mult |
| Stone Mason | $5 | Gains +8 Chips when a Stone Card scores, then gives its stored Chips |

### Uncommon

| Joker | Cost | Effect |
|---|---:|---|
| Keep Your Distance | $6 | X2 Mult if 4 or more scored cards are all numbered and use at least two ranks, no two of them closer than 3 ranks apart. Repeated ranks are fine |
| Patchwork | $6 | Retriggers the first scored card of each suit once |
| Blank Slate | $6 | Each scored card with no enhancement, seal or edition gives X1.10 Mult |
| Collector's Grade | $7 | Each scored card with an enhancement, an edition and a seal gives X1.5 Mult |
| Second Coat | $6 | Once per round, the first scored enhanced card with no edition has a 1 in 4 chance to become Foil |
| Safety Glass | $7 | Prevents the first Glass Card from shattering each round, and gains X0.1 Mult each time it saves one |

### Rare

| Joker | Cost | Effect |
|---|---:|---|
| Countdown | $9 | Retriggers each scored card once if the hand is a Straight made only of 2 to 10 |
| Compound Interest | $9 | On the first hand each round, gains X0.04 Mult per distinct scored rank from 2 to 10, up to X0.20 per round |
| Carbon Copy | $8 | Retriggers each scored card whose rank appears exactly twice in the hand |
| Color Theory | $8 | Retriggers the first scored card of each suit once |
| Counterfeit Seal | $8 | Retriggers each scored card with a Blue, Gold or Purple Seal once |
| Decimal Engine | $9 | Scored numbered cards give X current Mult. Seeing every rank from 2 to 10 in a round multiplies that value by X1.08 |
| Echo Chamber | $9 | Scored numbered cards retrigger once per earlier scored card of the same rank, up to 4 |

### Legendary

| Joker | Cost | Effect |
|---|---:|---|
| Long Division | $20 | Each scoring trigger of a numbered rank gives X(1 + 0.03 x trigger count), counted per rank and reset every hand |

## Config

`Mods -> Side Bets -> Config` toggles Jokers individually and the Endless
Ascension group (Decimal Engine, Echo Chamber, Long Division). Toggling one off
only keeps it out of the generation pools; copies already in a run keep working.

Blueprint and Brainstorm copy the scoring but not the permanent growth, so a
copy of Safety Glass gives its XMult without ever saving a card. Second Coat is
not Blueprint-compatible at all, since mutating cards is its whole job.

## Credits

Code and art by NeeoDev, GPL-3.0. Balatro by LocalThunk, Steamodded by the
Steamodded team, Lovely Injector by ethangreen-dev.

Unofficial fan mod, not affiliated with LocalThunk or Playstack.
