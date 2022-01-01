input ← •file.Lines "inputTest2"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

input ↩ FStringToInt⚇¯2 input
•Show fullCoords ← <˘∾⌜˜↕5
# one step
# 1. add 1
•Show iterOne←1+input

# stabilization steps
# 2. get coords which are > 9

•Show moreThan9Coords ← ∾(9<iterOne)/¨fullCoords
allPosDelta ← ∾<˘≍⌜˜¯1‿0‿1 # including self

# all possible positions (excluding out-of-bounds)
# in-bounds x > ¯1 ∧ y < 5 
allP ← ∧∾{
  a ← (𝕩⊸+)¨1‿1‿1‿1‿0‿1‿1‿1‿1/∾<˘≍⌜˜¯1‿0‿1
  (((∧´¯1⊸<)∧(∧´5⊸>))¨/⊢) a
}¨moreThan9Coords

allCounts ← ≠¨(⊐⊔⊢) allP
•Show (⊑⍷)¨(⊐⊔⊢) allP

•Show finalCounts ← 5‿5⥊allCounts×(∾fullCoords)∊allP
f ← finalCounts + >iterOne 

# 3. set all > 9 to 0
(9>f)×f


