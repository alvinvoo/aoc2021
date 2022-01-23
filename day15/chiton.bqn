
input ⇐ •file.Lines "input"

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
  input ← 𝕩
  size ← ≠input
  keys ← ⥊↕size‿size

  start ← 0‿0
  end ← ¯1⊑keys

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
  prevList ⇐ 0⥊˜≠keys # simply, @ cannot be used 

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
      prevList↩((≠nCInd)⥊<smallestNode)⌾(nCInd⊸⊏)prevList

      pQ ∾↩ (nCInd⊏keys)<⊸∾¨candidateDist
    }
  }

  #cost ⇐ ⊑(end<⊸(≡¨)keys)/distList
  # make it easier for this qns
  cost ⇐ ¯1⊑distList
  
  #path ⇐ ⟨end⟩ {
  #  𝕩≢0 ? n←⊑(𝕩<⊸(≡¨)keys)/prevList ⋄ (n<⊸∾𝕨)𝕊n ; 1↓𝕨
  #} end
}

# part 1
d ← Dijkstra input

•Show d.cost

# part 2
incrdMap ← +⌜˜↕5
p2Input←(9⊸<◶⊢‿(-⟜9))¨ ∾input⊸+¨incrdMap

d2 ← Dijkstra p2Input

•Show d2.cost
