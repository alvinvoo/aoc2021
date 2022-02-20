in ← •FLines "input"
do ← •ReBQN {repl⇐"strict"}

Tkr ← {1↑/"?[],"=𝕩}◶(⟨⟩⊸∾)‿"⟨"‿"⟩"‿","¨
Tkr1 ← {1↑/"?⟨⟩,"=𝕩}◶(⟨⟩⊸∾)‿"⟨"‿"⟩"‿","¨

IntToString ← {𝕊int:
  ret ← ⟨⟩
  {𝕊:
    ret∾˜↩@+48+<10|int
    int↩⌊int÷10
    int>0
  }•_while_⊢ int≥0
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
      (⊑ll)‿v
      }

    nrp←{((≠dnums)≤leftmoind+2)?¯1;
      ll←(leftmoind+2)‿(leftmoind+1) ⊑¨ <dnums
      v←IntToString AddM ll⊏sum
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

Step ← {exb‿spb𝕊a:
  {exb?
    #explode
    {𝕊:o‿b←Explode a⋄a↩b⋄o}•_while_⊢ 1⋄a
    ;
    spb?
      #split
      Split a;
      a}
}

Fc←{5≤≡Do∾𝕩}∾{×≠/2=≠¨𝕩}

input ← Tkr¨in

#step until 5>≡ and /2=≠¨ is ⟨⟩
Add1 ← {
  a←𝕨 AddTkr 𝕩
  sel←⟨⟩
  {𝕊: a↩sel Step a}•_while_{sel↩Fc𝕩⋄∨´sel} a
}

# part 1 - answer 4176
#•Show finArr⇐Do∾Add1˜´ ⌽input
#
Mag⇐{2≡≠𝕩?a‿b←𝕩⋄(3×a)+(2×b);𝕩}
#•Show Mag Mag¨ Mag⚇¯2 Mag⚇¯3 finArr

FMag ← {Mag Mag¨ Mag⚇¯2 Mag⚇¯3 𝕩}
f←input {l𝕊r: {l≡r?0;FMag∘Do∾l Add1 r}}⌜ input
•Show ⌈´⥊f
# first guess 4709 - too high (need sum of two DIFFERENT numbers)
# answer - 4633


