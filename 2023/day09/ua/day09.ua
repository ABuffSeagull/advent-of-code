# Experimental!

Extrapolate ← |1 (
  # Count Zeros
  =0/+.

  ⟨
    |1 # Not all zero
    # Dupe, then subtract adjacent numbers
    -,↻1.

    # Drop last useless value
    ↘¯1

    # Try again
    Extrapolate
    # Add last value of row
    +
  | ∘
  ⟩

  # Take last element of array
  ⊏¯1
)

⊜(⊜⋕ ≠ @\s .) ≠ @\n . &fras ⊏1 &args

&p$"Part 1: _" /+≡Extrapolate
