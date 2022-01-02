input ← •file.Lines "input"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

input ↩ >FStringToInt⚇¯2 input
len ← ≠input
fullCoords ← ∾⌜˜↕len
allPD ← 1‿1‿1‿1‿0‿1‿1‿1‿1/∾<˘≍⌜˜¯1‿0‿1
allP ← {(((∧´¯1⊸<)∧(∧´len⊸>))¨/⊢) allPD+<𝕩}¨fullCoords

flashArr ← 0

# part 1
Fn ← {
  # increase by 1
  iter ← 1+𝕩

  # for each coords starting from 0‿0, traverse the adjacent neighbors and look for value > 9
  # but need to maintain previous 0
  Fs ← {
    zeroMask ← ¬0=𝕩
    incrdMask ← +´¨9<allP⊑𝕩
    aftInc ← 𝕩+zeroMask×incrdMask

    o←(¬9<𝕩)×aftInc
    # synchronization step: need to keep iterating
    # as long as there are cells(>9)
    {∨´⥊9<𝕩}◶⊢‿𝕊 o
  }

  final ← Fs iter
  flashArr +↩ +´⥊0=final
  final
}

Fn⍟100 input
•Show flashArr
                      

