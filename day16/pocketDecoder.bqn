
hexK ← "0123456789ABCDEF"
hexV ← "0000"‿"0001"‿"0010"‿"0011"‿"0100"‿"0101"‿"0110"‿"0111"‿"1000"‿"1001"‿"1010"‿"1011"‿"1100"‿"1101"‿"1110"‿"1111"

##
in ← ∾hexV⊏˜hexK⊸(⊑∘⊐)¨⊑•FLines "input"
#•Show in ← ∾hexV⊏˜hexK⊸(⊑∘⊐)¨"9C0141080250320F1802104A08"

Bin2Int ← +´(2⊸⋆↕∘≠)×(⌽-⟜'0')
Match ← {𝕏𝕨}´
DoWhile ← {𝕨{𝕊⍟𝔽𝔾𝕩}𝕩@}´

#first, take 3, add version, check type id
#if its literal value, take next 5, if start is 1 (continue)

SClass ← {𝕊s:
  p ⇐ s  # store a global copy of the input 
  i ⇐ 0 # current cursor
  T ← ↑⋈↓
  Take ⇐ {n‿r←𝕩 T p⋄p↩r⋄i+↩𝕩⋄n}  # update the input whenever something taken 
}

sin ← SClass in

accumVer←0
Step ← {𝕊p:
  version ← p.Take 3
  typeid ← p.Take 3
  accumVer +↩ Bin2Int version

  •Show "type"
  •Show typeid

  Match typeid‿{
    "100": 
        c‿v←@‿⟨⟩
        DoWhile {𝕤⋄c≡"1"}‿{𝕤⋄
          c↩p.Take 1
          v∾↩p.Take 4
        }
        Bin2Int v
        ;
    𝕩: 
      lt←p.Take 1
      rs←{
        lt≡"1"? 
        noSub←Bin2Int p.Take 11
        {𝕊:Step p}¨↕noSub
        ;
        lt≡"0"?
        totalLen←Bin2Int p.Take 15
        endCur←p.i + totalLen
        ps←⟨⟩
        {𝕊:ps∾↩<Step p}•_while_{𝕊:p.i<endCur} @
        }
      op←Bin2Int 𝕩
      op◶+‿×‿⌊‿⌈‿!‿>‿<‿=´ rs
  }
}

# part 1
res←Step sin
•Show accumVer

#part 2
•Show res

# 1675198555015 - answer
