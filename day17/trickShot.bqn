#tax←20‿30
#tay←¯10‿¯5
tax←253‿280
tay←¯73‿¯46

StepX ← {
  Xf ← {+`⌽↕1+𝕩}
  xp ← Xf 𝕩
  ¯1⊑xp
}

cx ← 0
{𝕊: cx+↩1 ⋄ StepX cx} •_while_(≤⟜(⊑tax)) 1

•Show "least X value"
•Show cx

Step1Y ← {
  sy←𝕩
  ps←⟨sy⟩
  {𝕊:p←𝕩+sy-↩1 ⋄ ps∾↩<p ⋄ p}•_while_(≥⟜(⊑tay)) sy
  ps ¯1⊸↓↩
  #return empty if its out of range
  t←¯1⊑ps
  {(t≤1⊑tay)∧(t≥⊑tay)?ps;⟨⟩}
}

# part 1
# due to the highest reach should have the highest velocity and thus would
# land the furthest towards the bottom line of the target
# so try within ~70-73 and got the answer
#•Show ⌈´Step1Y 72

#answer: 2628

Step1X ← {
  sx←𝕩
  ps←⟨sx⟩
  {𝕊:p←𝕩+sx↩{sx≡0?0;sx-1} ⋄ ps∾↩<p ⋄ p}•_while_{(sx≢0)∧(1⊑tax)≥𝕩} sx
  ps
}

#•SHow "Y Values"
#•Show Step1Y 9 # = len 20
#•Show Step1Y 8 # = len 18
#•Show Step1Y 7 # = len 16
#•Show Step1Y 6 # = len 14
#•Show Step1Y 5 # = len 12
#•Show Step1Y 4 # = len 10
#•Show Step1Y 3 # = len 9
#•Show Step1Y 2 # = len 7
#•Show Step1Y 1 # = len 5 - 6
#•Show Step1Y 0 # = len 4 - 5
#•Show Step1Y ¯1 # = len 3 - 4
#•Show Step1Y ¯2 # len 2 - 3
#•Show Step1Y ¯3 # len 2
#•Show Step1Y ¯4 # len 2
#
#•Show "X values"
#•SHow Step1X 6  # ≥ b 20 at (len 5) - X 0 to 9  (special case)
#•SHow Step1X 7 # ≥ at len 4 - X ¯1 to 9  (sc)
#•SHow Step1X 8 # ≥ at len 3 but ≤ len 5 - X ¯2 to 1
#•SHow Step1X 9 # at len 3 - 4 -> X ¯2 to 0
#•Show Step1X 10 # at len 3 - X ¯2 to ¯1
#•Show Step1X 11 # at len 2 - 3 -> X ¯4 to ¯1
#•Show Step1X 12 # at len 2 -> X ¯4 to ¯2
#•Show Step1X 13 # at len 2 -> X ¯4 to ¯2 
#•Show Step1X 14 # same as above
#•Show Step1X 15 # same as above

•Show "how?"
Range←{l‿h←𝕩⋄l+↕(0-l)+1+h}
# first get all the Y value indices that are within the target range
yVals←Range ¯36‿72
yRanges←Step1Y¨yVals
•Show yRIndices←{/(𝕩≥⊑tay)∧(𝕩≤1⊑tay)}¨yRanges

# match those value indices to all X values
xVals←Range 22‿140
xRanges←Step1X¨xVals

# who has range until the edge?
rS←{(𝕩≥⊑tax)∧(𝕩≤1⊑tax)}¨xRanges
xUntilEdge←{∧´¯2‿¯1⊏𝕩}¨rS
•Show xRIndices←/¨rS

r1←xRIndices (∨´∘∊)⌜ yRIndices
lx‿ly←≢r1

•Show outsideTargetCount←(+´+˝(¬xUntilEdge)/r1)++´ly-⊑∘/˘xUntilEdge/r1
•Show insideTargetCount← (1+(1⊑tay)-⊑tay)×(1+(1⊑tax)-⊑tax)
totalCount←outsideTargetCount+insideTargetCount

# first guess: 1317 - wrong - too low
# second guess: 1412 - wrong - too high?

# answer: 1334

