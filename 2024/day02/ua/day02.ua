~ "../../utils.ua" ~ Split!

IsSafe ← (
  ↻1.
  ⊃(↥∩(/↧↘¯1) ⊃(<|>)
  | /↧↧⊃(≤3|≥1) ↘¯1 ⌵-
  )
  ↧
)

Part₁ ← (
  Split!(□Split!⋕ @\s) @\n
  ≡◇IsSafe
  /+
)

Part₂ ← (
  Split!(□Split!⋕ @\s) @\n
  ≡◇(
    IsSafe.
    ⨬(⊞≠.⇡ ⧻.
      ⊙¤
      ≡(IsSafe▽)
      /↥
    | 1
    ))
  /+
)

# &fras ⊏1 &args
# &p $"Part1: _" Part₁ .
# &p $"Part2: _" Part₂

┌─╴test
  $ 7 6 4 2 1
  $ 1 2 7 8 9
  $ 9 7 6 2 1
  $ 1 3 2 4 5
  $ 8 6 4 4 1
  $ 1 3 6 7 9
  ⍤⤙≍ 2 Part₁ .
  ⍤⤙≍ 4 Part₂
└─╴
