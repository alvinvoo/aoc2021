l ← >'0'-˜•FLines ≠◶"inputTest"‿⊑ •args

ll‿w‿sc‿c‿dirs⇐@‿@‿@‿@‿@
Init ← {𝕊:
  w ↩ ≠𝕩 # 10
  ll ↩ ⥊𝕩 # input flatten
  sc ↩ 0⌾⊑ (1+≠ll) ⥊ 10×+´ll # Distance list? with sum all (again mul by 10) as largest possible distance # append one more infront
  c ↩ 1‿w # x‿y delta?
  dirs ↩ ⥊¨ ∾{⟨(≠ll)¨∘⊏⊸(«⋈»)𝕩 ⋄ (≠ll)(«˘⋈»˘)𝕩⟩} w‿w⥊↕≠ll
}

Step ← {𝕊:
  •Show "STEP"
  •Show "p"
  •Show p ← c⊏sc
  •Show "c"
  •Show c
  •Show "neighbors"
  •Show nd ← c⊸⊏¨ dirs # neighbors?
  •Show "my dist"
  •Show c⊏ll
  •Show "cand distance"
  •Show n ← (c⊏ll) + ⌊´ ⊏⟜sc¨ nd  # candidate distance?

  •Show "selection"
  •Show m ← n<p
  sc (m/n)⌾((m/c)⊸⊏)↩ # update distance list
  #•Show "sc"
  #•Show sc
  •Show "next c"
  •Show c ↩ ⍷ ∾(m ∧ (≠ll)≠⊢)⊸/¨ nd
}

Init l
Step•_while_(×≠) c
•Show "final sc"
•Show sc
#•Show ¯2⊑sc

#Init 9⊸|⌾(-⟜1) ∾(<l) + +´¨↕5‿5
#Step•_while_(×≠) c
#•Show ¯2⊑sc



#### notes on dirs ####
#  using example input
#  w‿w⥊↕≠ll -> giving a 0 to 99 10x10 array
#  (≠ll)¨∘⊏⊸(«⋈»)𝕩  
#  assuming  𝕩 is that array
#  (100¨⊏𝕩) will give ⟨100 100 100 100 100 100 100 100 100 100⟩
# coz a constant function returns itself
#  (100¨∘⊏𝕩)(«⋈»)𝕩
# shift 100 to bottom and top rows of these pair of 10x10 and slap them together
#  100(«˘⋈»˘)𝕩 does the same but to right and left rows



