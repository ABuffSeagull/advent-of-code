Parse ← ≡⋕ ↘¯1
Uncompress ← (
  °⊏       # Index Compressed ? Compressed
  ♭≡˜⊟¯1   # Interwoven ? Index
  ˜▽ ˜↙⊙⊸⧻ # Expanded ? Interwoven Compressed
)

CompactLength ← ⧻ ▽⊸≥0

Checksum ← /+×°⊏

Part₁ ← (
  Parse
  Uncompress
  ⊸CompactLength
  ⊃(⊸<0 ↙|⇌▽⊸≥0 ↘) # Mask Buffer FillWith ? SplitIndex Uncompressed
  ⍜▽⋅              # Compacted ? Mask Buffer FillWith
  Checksum
)

Part₁ &fras⊏1 &args

# ┌─╴test
#   $ 2333133121414131402
#   $ 
#   ⍤⤙≍ 1928 Part₁
# └─╴
