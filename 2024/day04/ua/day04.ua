~ "../../utils.ua" ~ Split!

GenerateDiagonal ← ↘¯1 ◫ ⟜(⇡×2)⧻⊡0

Part₁ ← (
  Split!∘ @\n
  ⬚@\s[
    ⊃(∘
    | ⍉
    | ⬚@\s⊕∘ GenerateDiagonal.
    | ⬚@\s⊕∘ ≡⇌GenerateDiagonal.
    )]
  /⊂
  ⊂≡⇌.
  ⌕"XMAS"
  /+♭
)

⍣(&fras ⊏1 &args
  &p $"Part 1: _" Part₁)

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
  ⍤⤙≍ 18 Part₁
└─╴
