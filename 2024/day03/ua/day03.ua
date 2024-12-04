Part₁ ← (
  ⋕↘0_1 regex "mul\\((\\d+),(\\d+)\\)"
  /+/×⍉
)

Part₂ ← (
  .
  ⊃($No ¯ ⌕ "don't()"
  | $Yes ⌕ "do()")
  +
  ⍜⊢(⋅1)
  \(↧1↥0+)
  Part₁▽
)

⍣(&fras ⊏1 &args
  &p $"Part 1: _" Part₁ .
  &p $"Part 2: _" Part₂
)

┌─╴test
  $ xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  ⍤⤙≍ 161 Part₁
  $ xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
  ⍤⤙≍ 48 Part₂
└─╴
