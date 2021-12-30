input ← •file.Lines "inputTest"

# part 1
input ↩ '0' -˜ >input

#lr1 ← (9»˘input) - input
#lr2 ← (9«˘input) - input
#•Show lr ← (lr1 > 0) ∧ (lr2 > 0)

# refactored
lr ← ((0⊸<9⊸»˘-⊢)∧(0⊸<9⊸«˘-⊢)) input

#ud1← ⍉(9»˘⍉input) - ⍉input
#ud2← ⍉(9«˘⍉input) - ⍉input
#ud ← (ud1 > 0) ∧ (ud2 > 0)

# refactored
ud ← ((0⊸<9⊸»˘-⊢)∧(0⊸<9⊸«˘-⊢))⌾⍉ input

lowPointsMask ← lr ∧ ud

#allLowPoints ← (<˘(lr ∧ ud)) /¨ <˘input

# refactored
allLowPoints ← ∾lowPointsMask (/¨○<˘) input
+´1+((0⊸<≠)¨/⊢) allLowPoints

# part 2
# first iter
borderOf9 ← ¯1×input = 9
# append top, left walls of '9' borders 
#•Show borderOf9 ↩ {¯1 ∾˘ 𝕩} ⌾⍉ ¯1 ∾˘ borderOf9
#
#•Show first2rows ← 0‿1⊏borderOf9

globalCounter ← ¯1

•Show a ← ⥊˘⊏2‿2↕ first2rows

•Show firstPassRow ← {
  up‿left‿self←1↓𝕩

  # 3 scenarios:
  # if self ≢ ¯1, then return ¯1 (below 2 scn, assum self ≥ 0)
  # if up‿left ≡ ¯1 then return globalCounter+↩1 (new area)
  # if up OR left ≥ 0 then return the segment ≥ 0 (existing area)?? Another pass
  {
    self≡¯1?¯1;
      up‿left ≡ ¯1‿¯1?globalCounter +↩ 1; 
        globalCounter
  }
}˘ a

#2nd iter
borderOf9 ↩ (¯1∾firstPassRow)⌾(1⊸⊏) borderOf9

•Show next2rows ← 1‿2⊏borderOf9

•Show b ← ⥊˘⊏2‿2↕ next2rows

•Show {
  up‿left‿self←1↓𝕩

  # 3 scenarios:
  # if self ≢ ¯1, then return ¯1 (below 2 scn, assum self ≥ 0)
  # if up‿left ≡ ¯1 then return globalCounter+↩1 (new area)
  # if up OR left ≥ 0 then return the segment ≥ 0 (existing area)?? Another pass
  {
    self≡¯1?¯1;
      up‿left ≡ ¯1‿¯1?globalCounter +↩ 1; 
       ⊑(up‿left≥0)/up‿left  ## problem.. how to get the prevoius LEFT value?
  }
}˘b 
