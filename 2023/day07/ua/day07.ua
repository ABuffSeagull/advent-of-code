SplitString ← (|2 ⊜□≠,)

Rankings ← [[1 1] [2 1] [2 2] [3 1] [3 2] [4 1] [5 0]]
LabelOrder ← "23456789TJQKA"

SplitString @\n &fras ⊡1 &args

≡(
  # Parse out data
  ⊐(⊙⋕°⊟↘1⊢regex "([AKQJT2-9]{5})\\s+(\\d+)")
  .
  # Value from card order
  :/+×⊗⊙LabelOrder:ⁿ:¤13⇌⇡5
  # Value from hand type
  ⊏⍏.
  ⊕⧻⊛.
  ×ⁿ6 13⊢⊗:Rankings¤⬚0↙2⊏⍖.
  # Add both values
  +
)
&p$"Part 1: _" /+×+1⇡⧻.⊏⍏
