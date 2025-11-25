Parse ← ≡°□ ▽⊸≠{""} °(/$"_\n_")

# Result $ Location Field
InBounds ← /↧ ⊂⊃(≥0|>⊙△)

# Dir $ Loc Dir Field
NextDir ← (
  ⍜(⋅⋅∘)(⊚=@#)
  ⊃(/↥♭⌕+|⋅∘)
  ⍥⍣(
    0_1 °¯1_0
  | 1_0 °0_1
  | 0_¯1 °1_0
  | ¯1_0 °0_¯1
  )
)

# Loc Dir $ Loc Dir Field
Loop ← ⊸+ ⟜NextDir

Part₁ ← (
  ⊸($Loc ⊢⊚ =@^) $Field Parse
  ⊙($Dir ¯1_0)
  ⍢(⊸Loop ⤚⊙⊙∘)(InBounds ⊙⋅∘)
  ⧻◴
)

&p$"Part₁: _" Part₁ &fras⊡1 &args

┌─╴test
  Input ← (
    $ ....#.....
    $ .........#
    $ ..........
    $ ..#.......
    $ .......#..
    $ ..........
    $ .#..^.....
    $ ........#.
    $ #.........
    $ ......#...
  )

  ⍤⤙≍ 1 InBounds 0_0 Parse Input
  ⍤⤙≍ 0 InBounds 10_0 Parse Input

  ⍤⤙≍ 41 Part₁ Input
└─╴
