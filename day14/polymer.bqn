
input ← •file.Lines "input"
template ← ⊑•file.Lines "template"

FSplitString ← (⊢-˜¬×·+`1⊸»<⊢)∘∊˜⊔⊢

input ↩ >{" -> "FSplitString 𝕩}¨input

# how to get key-value
#a ← "NN"{1⊑⊏(𝕨⊸≡¨⊏˘)⊸/𝕩}input
Fg ← {0‿2‿1⊏∾⊏(𝕩⊸≡¨⊏˘)⊸/input}
Fj ← {(¯1↓𝕨)∾𝕩}
Fn ← {Fj˝Fg˘2↕𝕩}

# part 1
#step10←Fn⍟10 template
#≠¨⊐⊸⊔ step10

#(⌈´-⌊´) ≠¨⊐⊸⊔ step10

#part 2
#transform input values to indices instead
nl←((0‿2⊸⊏⋈2‿1⊸⊏)∾)˘input
keys ← ⊏˘input
indices ← ((keys⊸⊐⊏)≍(keys⊸⊐1⊸⊏))˘nl
pIn1 ← +˝(<˘2↕template) {𝕨≡⊑𝕩?1;0}⌜˘ <˘input

# stack overflow
#Fn2 ← {≠¨(≠𝕩)↑⊔⥊𝕩/indices}
#Fn2⍟9 pIn1

counterArr ← pIn1
Fn3 ← {
  in1←(⍉(/1⊸≤)≍(1⊸≤⊸/))𝕩
  
  eArr←(≠𝕩)⥊0
  {
   ind‿c←𝕩
   nI←⥊ind⊏indices
   {eArr↩(c⊸+)⌾(𝕩⊸⊑) eArr}¨nI
  }˘in1
  counterArr +↩ eArr
  eArr
}

# if input=1, =>get accum count for after 2nd step
# so for N=40, only need 39 steps
•Show Fn3⍟39 pIn1

•Show elements ← 1⊏˘input
•Show k←⊐elements

•Show uniq←⍷elements
t←(⊑≍≠)¨⊐⊸⊔ template
•Show initC←+˝t{(⊑𝕨)≡⊑𝕩?1⊑𝕨;0}⌜uniq

•Show "counterArr"
•Show (+´)¨k⊔counterArr

(⌈´-⌊´)initC+(+´)¨k⊔counterArr

# for after step 10
#"HFBVOPNCSK"
#⟨ 3978 2711 1490 3056 570 2643 2082 972 577 1378 ⟩

