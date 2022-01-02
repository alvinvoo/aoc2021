input ← •file.Lines "inputTest"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

input ↩ FStringToInt⚇¯2 input
len ← ≠input

fullCoords ← <˘∾⌜˜↕len

Fn ← {
# 1. add 1
•Show iterOne←1+𝕩

# stabilization steps
# 2. get coords which are > 9
# *** there might no > 9 coords, so here could be ⟨⟩
# in that case, just return iterOne
•Show moreThan9Coords ← ∾(9<iterOne)/¨fullCoords

{0<≠moreThan9Coords ? 

    # all possible positions (excluding out-of-bounds)
    # in-bounds x > ¯1 ∧ y < len 
    allP ← ∧∾{
      a ← (𝕩⊸+)¨1‿1‿1‿1‿0‿1‿1‿1‿1/∾<˘≍⌜˜¯1‿0‿1
      (((∧´¯1⊸<)∧(∧´len⊸>))¨/⊢) a
    }¨moreThan9Coords
    
# Problem: allCounts doesnt have positional info
    •Show allCounts ← ≠¨(⊐⊔⊢) allP
    #•Show (⊑⍷)¨(⊐⊔⊢) allP
    
    •Show finalCounts ← len‿len⥊allCounts×((∾fullCoords)∊allP)  # here fail
    f ← finalCounts + >iterOne  
    
    # 3. set all > 9 to 0
    9⊸>⊸× f ; iterOne}
}

•Show Fn⍟2 input


