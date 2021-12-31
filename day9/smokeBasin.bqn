input ← •file.Lines "input"

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
coordsMask ← ↕≢lowPointsMask

# x-y coord of all lowest points
•Show lowPointCoords ← ∾lowPointsMask (/¨○<˘) coordsMask

#withBorders ← {¯1∾˘𝕩∾˘¯1}⌾⍉ ¯1∾˘ (¯1×input=9) ∾˘¯1
•Show hr‿wr ← 1-˜≢input
•Show blockedCoords ← ∾(<˘input=9)/¨(<˘↕≢input)

FCount ← {
  # base conditions: if current cell x or y < 0 | x or y > range 
  # or coord already blocked/traversed
  # else, add 1 to counter
  # pass all up, down, left, right coords and counter recursively 
    y‿x ← 𝕩 
   {(∨´y‿x < 0)∨(y > hr)∨(x > wr)∨(⊑⟨y‿x⟩∊blockedCoords) ? 0 ; 
    blockedCoords ∾↩ ⟨y‿x⟩ ⋄ 
    1 + (FCount ⟨y,x-1⟩) + (FCount ⟨y,x+1⟩) + (FCount ⟨y-1,x⟩) + (FCount ⟨y+1,x⟩)}
}

×´3↑∨FCount¨lowPointCoords


