
hexK ← "0123456789ABCDEF"
hexV ← "0000"‿"0001"‿"0010"‿"0011"‿"0100"‿"0101"‿"0110"‿"0111"‿"1000"‿"1001"‿"1010"‿"1011"‿"1100"‿"1101"‿"1110"‿"1111"

#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"D2FE28"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"8A004A801A8002F478"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"620080001611562C8802118E34"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"C0015000016115A2E0802F182340"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"A0016C880162017C3686B18A3D4780"

##
•Show •FLines "input"
in ← ∾hexV⊏˜hexK⊸(⊑∘⊐)¨⊑•FLines "input"
litVals ← ⟨⟩

Bin2Int ← +´(2⊸⋆↕∘≠)×(⌽-⟜'0')
Match ← {𝕏𝕨}´
DoWhile ← {𝕨{𝕊⍟𝔽𝔾𝕩}𝕩@}´
T ← ↑⋈↓

#first, take 3, add version, check type id
#if its literal value, take next 5, if start is 1 (continue)
accumVer←0
Step ← {𝕊:
  header‿packets ← 6 T in
  version‿typeid ← 3 T header
  accumVer +↩ Bin2Int version

  Match typeid‿{
    "100": 
        c‿d‿p‿n←@‿@‿packets‿@
        DoWhile {𝕤⋄c≡"1"}‿{𝕤⋄
          n‿p↩5 T p
          c‿d↩1 T n
          litVals ∾↩ Bin2Int d
        }
        packets ↩ p
        ;
    𝕩: 
      noSub‿totalLen←0‿0
      lt‿p←1 T packets  
      {lt≡"1"? noSub‿p↩11 T p;totalLen‿p↩15 T p}
      packets ↩ p
  }
  in↩packets
}

Step •_while_ {𝕤⋄ 0≢+´'0'-˜𝕩} in
•Show accumVer
