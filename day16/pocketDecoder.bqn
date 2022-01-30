
hexK ← "0123456789ABCDEF"
hexV ← "0000"‿"0001"‿"0010"‿"0011"‿"0100"‿"0101"‿"0110"‿"0111"‿"1000"‿"1001"‿"1010"‿"1011"‿"1100"‿"1101"‿"1110"‿"1111"

##
in ← ∾hexV⊏˜hexK⊸(⊑∘⊐)¨⊑•FLines "input"
#in ← ∾hexV⊏˜hexK⊸(⊑∘⊐)¨"C200B40A82"
litVals ← ⟨⟩
fOrVals ← ⟨⟩

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
        c‿d‿p‿n‿v←@‿@‿packets‿@‿⟨⟩
        DoWhile {𝕤⋄c≡"1"}‿{𝕤⋄
          n‿p↩5 T p
          c‿d↩1 T n
          v∾↩d
        }
        fOrVals ∾↩ 0
        litVals ∾↩ Bin2Int v
        packets ↩ p
        ;
    𝕩: 
      noSub‿totalLen←0‿0
      lt‿p←1 T packets  
      {lt≡"1"? noSub‿p↩11 T p;totalLen‿p↩15 T p}
      fOrVals ∾↩ 1
      litVals ∾↩ Bin2Int 𝕩
      packets ↩ p
  }
  in↩packets
}

# part 1
Step •_while_ {𝕤⋄ 0≢+´'0'-˜𝕩} in
•Show accumVer

#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"C200B40A82"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"04005AC33890"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"880086C3E88112"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"CE00C43D881120"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"D8005AC2A8F0"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"F600BC2D8F"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"9C005AC2F8F0"
#∾hexV⊏˜hexK⊸(⊑∘⊐)¨"9C0141080250320F1802104A08"

# part 2
Sum←+´
Prod←×´
Min←⌊´
Max←⌈´
GT←>´
LT←<´
EQ←=´

func←Sum‿Prod‿Min‿Max‿@‿GT‿LT‿EQ

litVals ⌽↩
fOrVals ⌽↩
•Show litVals
•Show fOrVals

gr←⟨⟩
r←⟨⟩
Step2 ← {𝕊:
  l‿ln←1 T litVals
  f‿fn←1 T fOrVals
  {0≡⊑f?r↩l∾r; 
    #if r is already empty, means must process gr and reset gr to that one result
    {r≡⟨⟩?
      gr↩⟨gr{𝕏𝕨}func⊑˜l⟩;
       gr↩(r{𝕏𝕨}func⊑˜l)∾gr
       r↩⟨⟩}
  }
  litVals↩ln
  fOrVals↩fn
}

Step2 •_while_(0≢≠) litVals 
•Show gr
•Show r

# 32073632278762 - too high
