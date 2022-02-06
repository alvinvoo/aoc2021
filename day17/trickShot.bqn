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
{𝕊: cx+↩1 ⋄ StepX cx} •_while_(<⟜(⊑tax)) 1

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

•Show "how?"
Range←{l‿h←𝕩⋄l+↕(0-l)+1+h}
# first get all the Y value indices that are within the target range
yVals←Range ¯36‿72 # the range to examine is from (reverse) the MAX Y value able to satisfy the Y target range until about half of that value (in negative)
yRanges←Step1Y¨yVals
yRIndices←{/(𝕩≥⊑tay)∧(𝕩≤1⊑tay)}¨yRanges

largestYIndices←⌈´∾yRIndices

# match those value indices to all X values
xVals←Range 22‿140  # the range to examine is from the least X value able to satify the X target range until HALF of the distance, since if its more than half, next step will go out of range
xRanges←Step1X¨xVals

# who has range until the edge?
rS←{(𝕩≥⊑tax)∧(𝕩≤1⊑tax)}¨xRanges
xUntilEdge←{∧´¯2‿¯1⊏𝕩}¨rS
xRIndices←/¨rS
# first few rows extend until the end
# the LAST x indices need to match the largest indices of Y - which is 145
# in this example
# (until the end)
uEI←{inx←⊑𝕩 ⋄ inx+↕(largestYIndices+1-inx)}¨xUntilEdge/xRIndices
xRIndices↩uEI∾(¬xUntilEdge)/xRIndices

r1←xRIndices (∨´∘∊)⌜ yRIndices

•Show outsideTargetCount←+´+˝r1
•Show insideTargetCount←(1+(1⊑tay)-⊑tay)×(1+(1⊑tax)-⊑tax)
•Show totalCount←outsideTargetCount+insideTargetCount

# answer: 1334

# check: function to step thru each initial velocities
StepThru←{x‿y:
  dx‿dy←x‿y
  ps←⟨x‿y⟩
  {𝕊: 
    dx↩0⌈dx-1
    dy-↩1
    nv←dx‿dy+¯1⊑ps
    ps∾↩<nv
  } •_while_ {x‿y←¯1⊑𝕩 ⋄ ¬(x≥253)∧(y≤¯46)} ps
  #
  #{x‿y←¯1⊑𝕩 ⋄ (x≤280)∧(y≥¯73)} ps
}


