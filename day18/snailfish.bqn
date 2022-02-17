in ← •FLines "inputEx1"
do ← •ReBQN {repl⇐"strict"}

AddM ← +´{(+´{10⋆⌽↕≠𝕩}×(-⟜'0'))¨𝕩} 
•Show AddM ⟨"23","45","3"⟩

#for single positive digit addition only
AddS ← +○(-⟜'0')
Addition ← {"["∾𝕨∾","∾𝕩∾"]"}
IntToString ← {𝕊int:
  ret ← ⟨⟩
  {𝕊:
    ret∾˜↩@+48+<10|int
    int↩⌊int÷10
    int>0
  }•_while_⊢ int>0
  ret
}

#TODO: Can only run one `Explode` step only
#Need new struct ⟨"[","[".."15",.."13"..⟩ to replace `sum` for v←IntToString AddS´ ll⊏sum, so selector ll can still work 
#AddS change to AddM

Reduce ← {𝕊sum:
  •Show "new iter"
  bs←"[]"=˘≍˜sum
  wcs←¬+˝bs∾','=sum
  #need to cater for double digit (or triple?)
  #ft←wcs×¬0∾⟨1,1⟩⍷wcs
  •Show dnums←/wcs
  #convert sum to BQN array format in string
  arr←sum
  •Show arr↩¯1⊏"⟨⟩"{ds←/𝕩⋄arr (𝕨⥊˜≠ds)⌾(ds⊸⊏)↩}˘bs

  #token sum-to group digits together in an array

  barr←Do arr
  •Show ≡barr 

  {(5≤≡barr)?
    #get 4th level depth arrays selector
    levels←⟨⟩
    {s←2=≠𝕩⋄levels ∾↩ s}⚇¯4 barr
    leftmoind←⊑/levels
    #get left-most num index - get the pair indices
    •Show "lp rp"
    •SHow lp‿rp←leftmoind‿(1+leftmoind)⊏dnums
    •Show leftmoind

    #two new left-right regular values
    •Show nlp←{(0>leftmoind-1)?¯1;
      ll←(leftmoind-1)‿leftmoind ⊑¨ <dnums
      •Show "left v"
      •Show v←IntToString AddS´ ll⊏sum
      #cannot split first
      #vr←{v>9?{a‿b←(+⟜(48+@) ⌊≍⌈)𝕩⋄"["∾a∾","∾b∾"]"}v÷2;⟨v+48+@⟩}
      (⊑ll)‿v
      }

    •Show nrp←{((≠dnums)≤leftmoind+2)?¯1;
      ll←(leftmoind+2)‿(leftmoind+1) ⊑¨ <dnums
      •Show "right v"
      •Show v←IntToString AddS´ ll⊏sum
      #vr←{v>9?{a‿b←(+⟜(48+@) ⌊≍⌈)𝕩⋄"["∾a∾","∾b∾"]"}v÷2;⟨v+48+@⟩}
      (⊑ll)‿v
      }

    #replace range can only do from right to left
    #with starting index + len
    #assume first len = 1 for left and right regular
    #assume first len = 5 for target pair
    {nrp≢¯1?nr‿v←nrp⋄sum↩(nr↑sum)∾v∾(nr+1)↓sum;@}
    sum↩((lp-1)↑sum)∾"0"∾(5+lp-1)↓sum
    {nlp≢¯1?nl‿v←nlp⋄sum↩(nl↑sum)∾v∾(nl+1)↓sum;@}
    1‿sum;
    0‿sum}
}

#a←"[3,[2,[1,[7,3]]]]" Addition "[6,[5,[4,[3,2]]]]"
a←"[[[[4,3],4],4],[7,[[8,4],9]]]" Addition "[1,1]"
#a←"[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]" Addition "[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]"
#
{𝕊:o‿b←Reduce a⋄a↩b⋄o}•_while_⊢ 1

•Show a




