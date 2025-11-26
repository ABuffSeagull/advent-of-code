ParseLine ← ⍜°⊟˜⊓(⍜°□(⋕°/$"_ _")|⋕) °/$"_: _"
Parse     ← ≡◇ParseLine °/$"_\n_"

# Choices $ Equation
GetChoices₁ ← ⊟ ⊃(⍜⊏[0 /+]|⍜⊏[0 /×]) ↙2⊚ ⊸>0

GetChoices₂ ← ⊟₃ ⊃(⍜⊏[0 /+]|⍜⊏[0 /×]|⍜⊏[0 ⋕/$"__"°⋕]) ↙2⊚ ⊸>0

IsValid! ← (
  ∩°□ °⊟
  ⟜(⇌⬚0↯ ¤⧻)

  ±⧻path(⍣^[]|≍)
)

Part₁ ← (
  Parse
  /◇+⊏1 ⍉▽ wait⊸≡poolIsValid!(GetChoices₁)
)
Part₂ ← (
  Parse
  /◇+⊏1 ⍉▽ wait⊸≡poolIsValid!(GetChoices₂)
)

↘¯1 &fras⊏1 &args
&p$"Took: _s" ⊸⍜now(&p$"Part₁: _" Part₁)
&p$"Took: _s" ⍜now(&p$"Part₂: _" Part₂)

# ┌─╴test
#   $ 190: 10 19
#   $ 3267: 81 40 27
#   $ 83: 17 5
#   $ 156: 15 6
#   $ 7290: 6 8 6 15
#   $ 161011: 16 10 13
#   $ 192: 17 8 14
#   $ 21037: 9 7 18 13
#   $ 292: 11 6 16 20
#   ⍤⤙≍ 3749 Part₁
#   # ◌ ⍤⤙≍ 11387 Part₂
# └─╴
