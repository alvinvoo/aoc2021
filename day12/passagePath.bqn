input ← •file.Lines "input"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)

•Show input
input ↩ >⌽¨⊸∾ '-'FSplitString¨input
# then exclude those x-"start" and "end"-x
# coz there's only one way path from start till end 
a ← input {⊏˘𝕨≡¨<𝕩} "end"
b ← input {1⊏˘𝕨≡¨<𝕩} "start"
•Show input ↩ >(¬a+b)/<˘input

# part 1
Fn ← {
  traversedPath ← 𝕨
  q ← {(⊏˘input≡¨<𝕩)/1⊏˘input} 𝕩

  notYet ← q (¬∘∊/⊣) traversedPath
  capsOnly ← ((90>@-˜⊑¨)⊸/) q (∊/⊣) traversedPath

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

#o←⟨"start"⟩ Fn "start"
#+´o≡¨<"end"

# part 2
# input is 2 characters each!
Fn2 ← {
  traversedPath ← 𝕨
  q ← {(⊏˘input≡¨<𝕩)/1⊏˘input} 𝕩

  notYet ← q (¬∘∊/⊣) traversedPath
# uppercase: 65-90, lowercase: 97-122 
  already ← q (∊/⊣) traversedPath 

# get caps
  capsOnly ← (90≥@-˜⊑¨)⊸/ already 
# get lowercase
# first remove "end", then filter out by lowercase range
# potential lowercase to be traversed again
  #lowerOnly ← (97<@-˜⊑¨)⊸/ {(<"end")≢¨𝕩}⊸/ already 
  lowerOnly ← (97≤@-˜⊑¨)⊸/ already 

# traversed lowercases
  traverlowerOnly ← (97≤@-˜⊑¨)⊸/ traversedPath 

# only add those in lowerOnly list with count=1 in notYet list
# return empty ⟨⟩ as soon as there's a lowercase with 2 counts IN the
# traversed path list
# F ⟨"a","b","c"⟩ -> ⟨ "a" "b" "c" ⟩
# F ⟨"a","b","c","b"⟩ -> ⟨⟩
  onceLower ← {∧´1=≠¨⊐⊸⊔𝕩}◶⟨⟩‿lowerOnly traverlowerOnly

  notYet ↩ capsOnly∾onceLower∾notYet

  #•Show "one iter"
  #•Show traversedPath
  #•Show q
  #•Show notYet
  #•Show capsOnly
  #•Show lowerOnly
  #•Show ol
  #•Show onceLower 
#  #if notYet is ⟨⟩ return, else
#  #add back the Big caps (range 65-90) and
#  #recurse again for each notYet cell
   (0<≠)◶(traversedPath)‿(∾{(traversedPath∾⟨𝕩⟩)Fn2𝕩}¨) notYet
}

o←⟨"start"⟩ Fn2 "start"
+´o≡¨<"end"
