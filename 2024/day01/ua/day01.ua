Split! ← ⊜^0 ⊸≠ # Lines ? Char String

Part₁ ← (
  Split!□ @\n       # Lines ? String
  ◇≡(⊟∩⋕ °$"_   _") # Columns ? Lines
  ⍉                 # 
  ≡(⊏⍏.)            # Sorted ? Lists
  /+⌵/-             # Distance ? Sorted
)

Part₂ ← (
  Split!□ @\n       # Lines ? String
  ◇≡(⊟∩⋕ °$"_   _") # Columns ? Lines
  °⊟⍉               # FirstList SecondList ? Columns
  ⟜≡(/+=) ⊙¤        # FirstList Frequencies ? FirstList SecondList
  /+×               # SimilarityScore ? FirstList Frequencies
)

&fras ⊏1 &args
&p $"Part1: _" Part₁ .
&p $"Part2: _" Part₂

┌─╴test
  $ 3   4
  $ 4   3
  $ 2   5
  $ 1   3
  $ 3   9
  $ 3   3
  ⍤⤙≍ 11 Part₁ .
  ⍤⤙≍ 31 Part₂
└─╴
