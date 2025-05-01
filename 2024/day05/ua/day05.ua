~ "../../utils.ua" ~ Split!

# IsOrdered $ Pages Rules
CheckOrder ← (
  ⊃(:¤|$Length ⧻) # Pages Rules Length ?
  ⍜♭≡⊗            # RulePageIndex ? Pages Rules
  ⍜⍉(¬/↥) ⤚=      # RuleMask RPI ? RPI Length
  ▽               # FilteredRPI ?
  /↧ /≥ ⍉         # IsOrdered ?
)

Part₁ ← (
  ⊸⦷ "\n\n"
  °⊟ ⊜□ ¬
  ∩°□

  ⊓($Updates Split!(Split!⋕ @|) @\n
  | $Ordering Split!(□ Split!⋕ @,) @\n
  )

  ▽ ⤚≡◇CheckOrder :¤
  ≡◇(⊡⌊÷2 ⊸⧻)
  /+
)

⍣(
  &fras °□⊏1 &args
  &p $"Part 1: _" Part₁
)

┌─╴test
  $ 47|53
  $ 97|13
  $ 97|61
  $ 97|47
  $ 75|29
  $ 61|13
  $ 75|53
  $ 29|13
  $ 97|29
  $ 53|29
  $ 61|53
  $ 97|53
  $ 61|29
  $ 47|13
  $ 75|47
  $ 97|75
  $ 47|61
  $ 75|61
  $ 47|29
  $ 75|13
  $ 53|13
  $ 
  $ 75,47,61,53,29
  $ 97,61,53,29,13
  $ 75,29,13
  $ 75,97,47,61,53
  $ 61,13,29
  $ 97,13,75,29,47

  ⍤⤙≍ 143 Part₁
└─╴
