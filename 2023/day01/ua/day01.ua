SplitString ← (|2 ⊜□ ≠,)

ParseLine ← (|1 ⋕⊂⊃(⊢|⊢⇌)⊏⊚∊:"0123456789".)
&p$"Part 1: _" /+≡⊐ParseLine SplitString @\n &fras ⊡1 &args

FullDigits ← SplitString @\s "zero one two three four five six seven eight nine 0 1 2 3 4 5 6 7 8 9"
