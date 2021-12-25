
input ← •file.Lines "input"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

a←' 'FSplitString¨ input
input ↩ ∧˘>(FStringToInt⚇¯1∘FSplitString˜⟜','¨(⊑⋈¯1⊸⊑))¨ a

coorDiffs ← -´˘input
inputHors ← ({x‿y←𝕩⋄y=0}˘coorDiffs)/input
inputVerts ← ({x‿y←𝕩⋄x=0}˘coorDiffs)/input
inputDiagonal ← ({0=-´|𝕩}˘coorDiffs)/input

FRange ← {𝕨↓↕1+𝕩}
FAllHorsCoords ← {
  ⟨x1‿y1,x2‿y2⟩←𝕩
  (x1 FRange x2) ≍⌜ y2
}
FAllVertsCoords ← {
  ⟨x1‿y1,x2‿y2⟩←𝕩
  (y1 FRange y2) ≍⌜˜ x2
}
allHorsCoords ← ∾FAllHorsCoords¨ <˘inputHors
allVertsCoords ← ∾FAllVertsCoords¨ <˘inputVerts
#Solution 1
allCoords ← allHorsCoords ∾ allVertsCoords
•Show howManyOverlappedOnce ← +´1=⊒allCoords

#Solution 2
FAllDiagonalCoords ← {
  ⟨x1‿y1,x2‿y2⟩←𝕩
  
  xRange ← x1 <◶(⌽∘FRange˜)‿FRange x2
  yRange ← y1 <◶(⌽∘FRange˜)‿FRange y2

  xRange ≍¨ yRange 
}
allDiagonalCoords ← ∾FAllDiagonalCoords¨ <˘inputDiagonal
allCoords2 ← allDiagonalCoords ∾ allHorsCoords ∾ allVertsCoords
•Show howManyOverlappedOnce2 ← +´1=⊒allCoords2
