input ← •file.Lines "inputTest2"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

input ↩ >⌽¨⊸∾ '-'FSplitString¨input
# then exclude those x-"start" and "end"-x
# coz there's only one way path from start till end 
a ← input {⊏˘𝕨≡¨<𝕩} "end"
b ← input {1⊏˘𝕨≡¨<𝕩} "start"
•Show input ↩ >(¬a+b)/<˘input

# first, grab "start"
Fn ← {
  traversedPath ← 𝕨
  q ← {(⊏˘input≡¨<𝕩)/1⊏˘input} 𝕩
  notYet ← q (¬∘∊/⊣) traversedPath
  capsOnly ← (90>@-˜⊑¨)⊸/ q (∊/⊣) traversedPath

  notYet ∾↩ capsOnly

  #•Show "one iter"
  #•Show traversedPath
  #•Show q
  #•Show notYet
  #•Show capsOnly
#  #if notYet is ⟨⟩ return, else
#  #add back the Big caps (range 65-90) and
#  #recurse again for each notYet cell
   (0<≠)◶(traversedPath)‿(∾{(traversedPath∾⟨𝕩⟩)Fn𝕩}¨) notYet
}

o←⟨"start"⟩ Fn "start"
+´o≡¨<"end"

