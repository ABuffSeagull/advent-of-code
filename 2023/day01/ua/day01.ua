SplitString ← (|2 ⊜□ ≠,)

Lines ← SplitString @\n &fras ⊡1 &args

ParseLine ← (|1 ⋕⊂⊃(⊢|⊢⇌)⊏⊚∊:"0123456789".)
&p$"Part 1: _" /+≡⊐ParseLine Lines

FullDigits ← SplitString @\s "zero one two three four five six seven eight nine 0 1 2 3 4 5 6 7 8 9"

FindDigits ← (|1 ◿10 ⊚ ≡/+ ⊐≡⌕ FullDigits ↯ ⧻ FullDigits)
DigitOrder ← (|1 ⍏ ≡(⊢⊚) ⊏⊚ ≡/+. ⊐≡⌕ FullDigits ↯ ⧻ FullDigits)
ParseLineSecond ← (|1 +⊃(×10⊢|⊢⇌)⊏DigitOrder:FindDigits .)
&p$"Part 2: _" /+≡⊐ParseLineSecond Lines
