~ "../../utils.ua" ~ Split!

Monotonic! ← /↧↘¯1^0↻1. # IsMonotonic ? List

IsSafe ← (
  ⊃($Monotonic ↥⊃(Monotonic!>|Monotonic!<)
  | $WithinDiff /↧↧⊃(≤3|≥1)⌵↘¯1-↻1.)
  ↧
)

Part₁ ← (
  Split!(□Split!⋕ @\s) @\n
  ≡◇IsSafe
  /+
)

&fras ⊏1 &args
&p $"Part1: _" Part₁

┌─╴test
  $ 7 6 4 2 1
  $ 1 2 7 8 9
  $ 9 7 6 2 1
  $ 1 3 2 4 5
  $ 8 6 4 4 1
  $ 1 3 6 7 9
  ⍤⤙≍ 2 Part₁
└─╴
