~ "../../utils.ua" ~ Split!

GenerateDiagonal ← ↘¯1 ⧈∘ ⟜(⇡×2)⧻⊡0

Part₁ ← (
  Split!∘ @\n
  ⬚@\s[⊃(∘|⍉|⬚@\s⊕∘ GenerateDiagonal.|⬚@\s⊕∘ ≡⇌GenerateDiagonal.)]
  /⊂
  ⊂≡⇌.
  ⌕"XMAS"
  /+♭
)

Part₂ ← (
  Split!∘ @\n
  ⧈(["M S" " A " "M S"]
    ["M M" " A " "S S"]
    ◡∩⇌
    ◡∩₄≡⇌
    ◴⊟₈
    =⊙¤
    ≡(/+♭)
    =5
    /+
  ) 3_3
  /+♭
)

⍣(
  &fras ⊏1 &args
  &p $"Part 1: _" Part₁ .
  &p $"Part 2: _" Part__2
)

┌─╴test
  $ MMMSXXMASM
  $ MSAMXMSMSA
  $ AMXSXMAAMM
  $ MSAMASMSMX
  $ XMASAMXAMM
  $ XXAMMXXAMA
  $ SMSMSASXSS
  $ SAXAMASAAA
  $ MAMMMXMMMM
  $ MXMXAXMASX
  ⍤⤙≍ 18 Part₁ .
  ⍤⤙≍ 9 Part₂
└─╴
