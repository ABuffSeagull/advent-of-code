~ "../../utils.ua" ~ Split!

Split!□ @\n &fras ⊡1 &args
# Get directions
°□⊃(⊢|↘1)
⊙(
  ≡(
    # Parse line
    °$"_ = (_, _)"
    # Couple LR directions
    ⊙⊟
  )
  map
  # Add initial location
  "AAA"
)
0
⍢(
  # Inside counter
  ⊙(
    # Inside directions
    ⊙(⊸get)
    # Get correct branch
    ⊙(⊏=@R⊢).
    # Rotate directions
    ↻1
  )
  # Add counter
  +1
)(¬≍"ZZZ":⊙,)
&p$"Part 1: _"⊙⋅⋅⋅
