~ "../../utils.ua" ~ Split!

# NewNumber ? List
Extrapolate ← |1 (
  # Is all zero?
  ≠0/+ .

  ⍥(|1
    # Not all zero
    # Dupe, then subtract adjacent numbers
    -,↻1 .

    # Drop last useless value
    ↘¯1

    # Try again
    Extrapolate
    # Add last value of row
    +
  )

  # Take last element of array
  ⊏¯1
)

&fras ⊏1 &args
Split!(Split!⋕ @\s) @\n

&p$"_" /+≡Extrapolate
