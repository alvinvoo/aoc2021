in ← •FLines "inputEx1"
do ← •ReBQN {repl⇐"strict"}

Tkr ← {1↑/"?[],"=𝕩}◶(⟨⟩⊸∾)‿"⟨"‿"⟩"‿","¨
Tkr1 ← {1↑/"?⟨⟩,"=𝕩}◶(⟨⟩⊸∾)‿"⟨"‿"⟩"‿","¨

IntToString ⇐ {𝕊int:
  ret ← ⟨⟩
  {𝕊:
    ret∾˜↩@+48+<10|int
    int↩⌊int÷10
    int>0
  }•_while_⊢ int>0
  ret
}
StringToInt ← +´{10⋆⌽↕≠𝕩}×(-⟜'0')
Addition ← {"["∾𝕨∾","∾𝕩∾"]"}
AddTkr ← {⟨"⟨"⟩∾𝕨∾⟨","⟩∾𝕩∾⟨"⟩"⟩}

AddM ← +´StringToInt¨

Explode ← {𝕊sum:
  #non numbers selectors
  bs←"⟨"‿"⟩"‿","≡¨˘sum∾≍˜sum
  #numbers selector
  ns←¬+˝bs

  dnums←/ns
  #convert sum to BQN array format in string
  barr←Do ∾sum
  {(5≤≡barr)?
    #get 4th level depth arrays selector
    levels←⟨⟩
    {s←2=≠𝕩⋄levels ∾↩ s}⚇¯4 barr
    leftmoind←⊑/levels
    #get left-most num index - get the pair indices
    lp‿rp←leftmoind‿(1+leftmoind)⊏dnums
    leftmoind

    #two new left-right regular values
    nlp←{(0>leftmoind-1)?¯1;
      ll←(leftmoind-1)‿leftmoind ⊑¨ <dnums
      v←IntToString AddM ll⊏sum
      #cannot split first
      #vr←{v>9?{a‿b←(+⟜(48+@) ⌊≍⌈)𝕩⋄"["∾a∾","∾b∾"]"}v÷2;⟨v+48+@⟩}
      (⊑ll)‿v
      }

    nrp←{((≠dnums)≤leftmoind+2)?¯1;
      ll←(leftmoind+2)‿(leftmoind+1) ⊑¨ <dnums
      v←IntToString AddM ll⊏sum
      #vr←{v>9?{a‿b←(+⟜(48+@) ⌊≍⌈)𝕩⋄"["∾a∾","∾b∾"]"}v÷2;⟨v+48+@⟩}
      (⊑ll)‿v
      }

    #replace range can only do from right to left
    #with starting index + len
    #assume first len = 1 for left and right regular
    #assume first len = 5 for target pair
    {nrp≢¯1?nr‿v←nrp⋄sum↩(nr↑sum)∾⟨v⟩∾(nr+1)↓sum;@}
    sum↩((lp-1)↑sum)∾⟨"0"⟩∾(5+lp-1)↓sum
    {nlp≢¯1?nl‿v←nlp⋄sum↩(nl↑sum)∾⟨v⟩∾(nl+1)↓sum;@}
    1‿sum;
    0‿sum}
}

Split ← {𝕊in:
  s←/2=≠¨in
  {s≡⟨⟩?in;
    fpos←⊑s
    t←StringToInt fpos⊑in
    splitted←{a‿b←(IntToString¨ ⌊≍⌈)𝕩÷2⋄⟨"⟨"⟩∾⟨a⟩∾⟨","⟩∾⟨b⟩∾⟨"⟩"⟩}t
    (fpos↑in)∾splitted∾(fpos+1)↓in}
}

#a←"[3,[2,[1,[7,3]]]]" Addition "[6,[5,[4,[3,2]]]]"
#a←"[[[[4,3],4],4],[7,[[8,4],9]]]" AddTkr○Tkr "[1,1]"
#a←"[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]" AddTkr○Tkr "[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]"
#
Step ← {𝕊a:
  {(5=≡Do ∾a)?
    #explode
    {𝕊:o‿b←Explode a⋄a↩b⋄o}•_while_⊢ 1⋄a
    ;
    (×≠/2=≠¨a)?
      #split
      Split a;
      a}
}

#step until 5>≡ and /2=≠¨ is ⟨⟩
a←"[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]" AddTkr○Tkr "[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]"
•Show Step⍟15 a








