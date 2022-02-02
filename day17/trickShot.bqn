tax←253‿280
tay←¯73‿¯46

StepX ← {
  Xf ← {+`⌽↕1+𝕩}
  xp ← Xf 𝕩
  ¯1⊑xp
}

cx ← 0
{𝕊: cx+↩1 ⋄ StepX cx} •_while_(≤⟜(⊑tax)) 1

•Show "X value"
•Show cx

Step1Y ← {
  sy←𝕩
  ps←⟨⟩
  {𝕊:p←𝕩+sy-↩1 ⋄ ps∾↩<p ⋄ p}•_while_(≥⟜(⊑tay)) sy
  ps ¯1⊸↓↩
  #return empty if its out of range
  t←¯1⊑ps
  {(t≤1⊑tay)∧(t≥⊑tay)?ps;⟨⟩}
}

yVals←⟨⌈´Step1Y 1⟩
•Show "Y value"

cy ← 1
#{𝕊: cy+↩1 ⋄ p←⌈´Step1Y cy ⋄ yVals∾↩<p ⋄ p } •_while_(≥⟜(¯1⊑yVals)) cy
•Show cy
•Show yVals
# part 1
# due to the highest reach should have the highest velocity and thus would
# land the furthest towards the bottom line of the target
# so try within ~70-73 and got the answer
•Show ⌈´Step1Y 72

#1st guess: 630 wrong
#answer: 2628

