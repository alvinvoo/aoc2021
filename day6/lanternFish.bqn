
input ← ⊑•file.Lines "input"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

•Show initState ← FStringToInt¨',' FSplitString input

# one iteration
# 1. minus 1
# 2. check if any element < 0 (or = ¯1)
# 3. if there is, change that elem to 6 and append an 8 behind
# 4. else, just return array
FCycle ← {
 newArray ← 𝕩-1
 encoder ←¯1=newArray
 newArray ↩ newArray+7×encoder

 (0⊸<)◶newArray‿{∾⟜8⍟𝕩 newArray} ≠/encoder 
}
#solution 1
#•Show FCycle⍟16 initState
#•Show FCycle⍟21 initState
#•Show FCycle⍟32 initState
#•Show FCycle⍟40 initState

#solution 2
# stack overflow

# 0 - 8: 9 days array
#https://todd.ginsberg.com/post/advent-of-code/2021/day6/ 
cycleArray ← 9⥊0
{ cycleArray ↩(1⊸+)⌾(𝕩⊸⊑) cycleArray }¨initState

FCycle2 ← {
  dayAfter ← 1⌽𝕩
  {(⊑⌽dayAfter)⊸+}⌾ (6⊸⊑) dayAfter
}

•Show +´FCycle2⍟256 cycleArray

