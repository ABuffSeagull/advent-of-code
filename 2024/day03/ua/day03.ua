Part₁ ← (
  ⋕↘0_1 regex "mul\\((\\d+),(\\d+)\\)"
  /+/×⍉
)

⍣(&fras ⊏1 &args
  &p $"Part 1: _" Part₁
)

┌─╴test
  $ xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  ⍤⤙≍ 161 Part₁
└─╴
