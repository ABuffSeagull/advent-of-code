SplitString ← (|2 ⊜□≠,)

SplitString @\n &fras ⊡1 &args
# Get directions
°□⊃(⊢|↘1)
⊙(
  # Parse lines
  ≡(≡°□↘1♭regex "(\\w{3}) = \\((\\w{3}), (\\w{3})\\)")
  # Split out mapping
  ⊃(≡⊢|≡↘1)
  # Add initial location
  "AAA"
)
0
⍢(
  # Inside counter
  ⊙(
    # Inside directions
    ⊙(
      # Duplicate mapping
      ⊙,⊙,
      # Get current mapping
      ⊏⊢⊚≡≍¤
    )
    # Get correct branch
    ⊙(⊏=@R⊢).
    # Rotate directions
    ↻1
  )
  # Add counter
  +1
)(¬≍"ZZZ":⊙,)
;;;;&p$"Part 1: _"
