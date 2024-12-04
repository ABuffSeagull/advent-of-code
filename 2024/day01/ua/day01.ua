~ "../../utils.ua" ~ Split!
ParseLine ← ⋕[°$"_   _"] # Nums ? String

Part₁ ← (
  Split!ParseLine @\n # Nums ? String
  ⍉                   # Lists ? Nums
  ≡(⊏⍏.)              # Sorted ? Lists
  /+⌵/-               # Distance ? Sorted
)

Part₂ ← (
  Split!ParseLine @\n # Lines ? String
  :⊓$First$Second °⊟⍉ # FirstList SecondList ? Columns
  $Occurrences ⊸⊞=
  $Frequencies /+
  $Similarity /+×
)

⍣(&fras ⊏1 &args
  &p $"Part1: _" Part₁ .
  &p $"Part2: _" Part₂)

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
