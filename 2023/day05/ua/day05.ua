SplitString ← (|2 ⊜□≠,)

RunMap ← (|2
  # Push original
  ⊙.
  # Spread array on stack
  ⊙(°[⊙⊙∘]):
  # Get offset from start
  :⊙(↧⊃(>|≥0)).-:
  # Get mapped value
  /+♭×¤⊙⊟
  # Return original if mapping is 0
  (∘|⋅∘) =0 .
)

.&fras ⊡1 &args
≡(⊡1) regex "map:\\s((?:\\d+\\s)+)"
≡(
  ⍜(
    °□
  | SplitString @\n
    ⍉≡(↻1 ⋕ SplitString @\s °□)
  )
)
⋕ SplitString @\s °□⊡0_1 regex "seeds:\\s((?:\\d+ ?)+)":
&p$"Part 1: _" /↧≡(⊐∧RunMap:),,⊙¤

&p$"Part 2: _" /↧≡(⊐∧RunMap:)⊐/⊂≡(□+⇡°⊟⇌)⊕∘⌊÷2⇡⧻.
