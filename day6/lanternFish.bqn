
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
#•Show ≠FCycle⍟80 initState

#solution 2
# stack overflow
# can i split?
first100 ← FCycle⍟100 initState
second100 ← FCycle⍟100 first100
•Show ≠second100
