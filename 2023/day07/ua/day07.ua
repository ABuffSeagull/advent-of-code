SplitString ← (|2 ⊜□≠,)

Rankings ← [[1 1] [2 1] [2 2] [3 1] [3 2] [4 1] [5 0]]
LabelOrder ← "23456789TJQKA"
SecondLabelOrder ← "J23456789TQKA"

SplitString @\n &fras ⊡1 &args
.
≡(
  # Parse out data
  ⊐(⊙⋕°⊟↘1⊢regex "([AKQJT2-9]{5})\\s+(\\d+)")
  .
  # Value from card order
  :/+×⊗⊙LabelOrder:ⁿ:¤13⇌⇡5
  # Value from hand type

  # Sort
  ⊏⍏.
  # Count occurences
  ⊕⧻⊛.
  # Get top 2 occurences
  ⬚0↙2⊏⍖.
  # Find type ranking
  ⊢⊗:Rankings¤
  # Hash value
  ×ⁿ6 13
  # Add both values
  +
)
&p$"Part 1: _" /+×+1⇡⧻.⊏⍏

≡(
  # Parse out data
  ⊐(⊙⋕°⊟↘1⊢regex "([AKQJT2-9]{5})\\s+(\\d+)")
  .
  # Value from card order
  :/+×⊗⊙SecondLabelOrder:ⁿ:¤13⇌⇡5
  # Value from hand type

  # Count Jokers
  :⊟:0/+=@J.
  # Drop Jokers
  ▽≠@J.
  # Sort
  ⊏⍏.
  # Count occurences
  ⊕⧻⊛.
  # Get top 2 occurences
  ⬚0↙2⊏⍖.
  # Add jokers in
  +
  # Find type ranking
  ⊢⊗:Rankings¤
  # Hash value
  ×ⁿ6 13
  # Add both values
  +
)
&p$"Part 2: _" /+×+1⇡⧻.⊏⍏
