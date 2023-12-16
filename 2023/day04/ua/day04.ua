SplitString ← (|2 ⊜□ ≠ ,)

CountMatches ← (|1
  # Grab out both chunks of numbers, and put on stack
  °⊟ ≡⊢ ↘1 regex "((?:\\d+\\s*)+)"
  # Parse each chunk
  ∩(≡⋕ SplitString @\s °□)
  # Count up matching numbers
  /+ ∊
)

PropagateCards ← (|1
  # Array of ones for number of cards
  ↯:1⧻.
  # Multiply matches by current amount of cards,
  # add to following cards, then rotate arrays
  ⍥(∩(↻1)⬚0+⊂0↯:⊢,⊢,)⧻.
  # Total up amount of cards, discard original matches array
  ;:/+
)

.≡CountMatches SplitString @\n &fras ⊡1 &args
&p$"Part 1: _" /+
&p$"Part 2: _" PropagateCards
