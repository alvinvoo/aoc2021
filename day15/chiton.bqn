
input ⇐ •file.Lines "inputTest"

input↩>{𝕩-'0'}¨input

# find adjacent list (up, down, left, right) with coordinates

FindAdjN ← {
  y‿x←𝕩
  size←𝕨
  p←⟨(y+1)‿x,y‿(x+1),(y-1)‿x,y‿(x-1)⟩
  c←{y‿x←𝕩⋄(y≥0)∧(x≥0)∧(y<size)∧(x<size)}¨p
  c/p
}

While ← {𝕩{𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}𝕨@}´
FSortDistList ← (⍋1⊸⊏˘∘>)⊸⊏

Dijkstra ← {
  start ← 𝕨
  end ← 𝕩
  size ← ≠input
  keys ← ⥊↕size‿size

  # Priority node queue
  arr ← ∞⥊˜≠keys
  i ← keys ⊑∘⊐<start 
  # replace the `start` value with 0
  # TODO: pQ probably dont need all the ∞ inits
  #•Show pQ ← keys<⊸∾¨0⌾(i⊸⊑) arr

  pQ ← ⟨start⋈0⟩

  # Distance list
  distList ⇐ 0⌾(i⊸⊑)arr
  done ← 0

  # Previous list
  #prevList ⇐ 0⥊˜≠keys # simply, @ cannot be used 

  While {𝕤⋄(done≠1) ∧ (0<≠pQ)}‿{𝕤
    # sort, get smallest value and drop + reassign
    pQ ↩ FSortDistList pQ
    smallestNode←⊑⊑pQ
    pQ ↩ 1↓pQ

    {
      smallestNode≡end ? done↩1 ; 
      #find all neighboring nodes of this `smallest`
      
      nbNodes←size FindAdjN smallestNode
      smDist←⊑(keys⊐<smallestNode)⊏distList
      candidateDist←smDist+nbNodes⊑input

      nbInd←keys⊐nbNodes
      sC←candidateDist<nbInd⊸⊏distList
      nCInd←sC/nbInd
      candidateDist /˜↩sC

      distList↩candidateDist⌾(nCInd⊸⊏)distList
      #prevList↩((≠nCInd)⥊<smallestNode)⌾(nCInd⊸⊏)prevList

      pQ ∾↩ (nCInd⊏keys)<⊸∾¨candidateDist
    }
  }

  #cost ⇐ ⊑(end<⊸(≡¨)keys)/distList
  # make it easier for this qns
  •Show distList
  cost ⇐ ¯1⊑distList
  
  #path ⇐ ⟨end⟩ {
  #  𝕩≢0 ? n←⊑(𝕩<⊸(≡¨)keys)/prevList ⋄ (n<⊸∾𝕨)𝕊n ; 1↓𝕨
  #} end
}

# part 1
d ← 0‿0 Dijkstra 9‿9

# 10 secs - 447
•Show d.cost

# part 2
# doesnt work; run forever
#incrdMap ← +⌜˜↕5
#•Show ≢p2Input←(9⊸<◶⊢‿(-⟜9))¨ ∾input⊸+¨incrdMap

# revert to original array
FindAdjN2 ← {
  y‿x←𝕩
  size←10
  limit←𝕨
  
  delta←+´⌊𝕩÷size

  p←⟨(y+1)‿x,y‿(x+1)⟩
  c←{y‿x←𝕩⋄(y<limit)∧(x<limit)}¨p
  z←c/p
  ⟨z,delta,(size|z)⟩
}

Dijkstra2 ← {
  start ← 𝕨
  end ← 𝕩
  size ← 1+⊑𝕩
  keys ← ⥊↕size‿size

  # Priority node queue
  arr ← ∞⥊˜≠keys
  i ← keys ⊑∘⊐<start 
  pQ ← ⟨start⋈0⟩

  distList ⇐ 0⌾(i⊸⊑)arr
  done ← 0

  While {𝕤⋄(done≠1) ∧ (0<≠pQ)}‿{𝕤
    # sort, get smallest value and drop + reassign
    pQ ↩ FSortDistList pQ #need to control sorting array size
    smallestNode←⊑⊑pQ
    pQ ↩ 1↓pQ

    {
      smallestNode≡end ? done↩1 ; 
      #find all neighboring nodes of this `smallest`
      
      nbNodes‿delta‿oNb←500 FindAdjN2 smallestNode
      smDist←⊑(keys⊐<smallestNode)⊏distList
      acNDist←(9⊸<◶⊢‿(-⟜9))¨ delta+oNb⊑input

      candidateDist←smDist+acNDist #<--

      nbInd←keys⊐nbNodes
      sC←candidateDist<nbInd⊸⊏distList
      nCInd←sC/nbInd
      candidateDist /˜↩sC

      distList↩candidateDist⌾(nCInd⊸⊏)distList

      pQ ∾↩ (nCInd⊏keys)<⊸∾¨candidateDist
    }
  }
  cost ⇐ ¯1⊑distList
}

#d2 ← 0‿0 Dijkstra2 499‿499

#•Show d2.cost
