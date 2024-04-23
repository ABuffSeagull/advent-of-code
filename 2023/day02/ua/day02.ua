# Experimental!

ParseColor ← (
  # Split on whitespace

  # {"3", "blue"}
  ⊜□≠@\s.
  # Parse the number

  # {3, "blue"}
  ⍜(⊢|⋕)
  # spread onto stack

  # 3
  # "blue"
  :∩°□°⊟
  # Make test colors

  # 3
  # {"blue", "blue", "blue"}
  # {"red", "green", "blue"}
  [⊙⊙∘]◌∩∩□."red" "green" "blue"
  # Duplicate current color 3 times

  # 3
  # {"blue", "blue", "blue"}
  # {"red", "green", "blue"}
  ⊙(↯3)
  # Match each color

  # 3
  # [0, 0, 1]
  ≡(≍°□)
  # Multiply it by count

  # [0, 0, 3]
  ×
)

ParsePull ← (
  # Split on colors
  ⊜□¬⦷", ".
  # Parse each color
  ≡◇ParseColor
  # Add colors together
  /+
)

ParseLine ← (
  # Drop inital game id
  ↘+2⊚⌕@:.
  # Split pulls
  ⊜□¬⦷"; ".
  # Do all pulls
  ≡◇ParsePull
)

# Split lines
.⊜□⊸≠@\n &fras ⊡1 &args
# Parse Lines
≡◇(
  ParseLine
  # Make sure all are less than limits
  ≤¤12_13_14
  # And them together
  /↧♭
)
# Find each index, +1 for id, sum
&p$"Part 1: _" /+ +1 ⊚

≡◇(
  ParseLine
  # Find max amount of each color
  /↥
  # Find the "power"
  /×
)
&p$"Part 2: _" /+
