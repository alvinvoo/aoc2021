
input ← •file.Lines "input"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

•Show input ↩ ∧FStringToInt¨ ','FSplitString ⊑input

# dedup
•Show dedupIn ← ⍷input

# count
•Show count ← ≠¨⊐⊸⊔input

# •Show firstIter ← |1-˜dedupIn 
# •Show +´firstIter×count 

# part 1
•Show +´count×{|𝕩-˜dedupIn}¨dedupIn
•Show "part 1 answer"
•Show ⌊´+´count×{|𝕩-˜dedupIn}¨dedupIn

# part 2
# but seems like need to include ALL possible positions (including those not
# occupied by a crab
•Show "part 2 answer"
fullRange ← ↕1+⌈´input

countFRange ← +´˘fullRange =⌜ input
•Show ⌊´+´countFRange×{+´1+↕𝕩}⚇¯2{|𝕩-˜fullRange}¨fullRange





