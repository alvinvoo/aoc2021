
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
•Show "part 1"
•Show step10←Fn⍟10 template
•Show ⊐⊸⊔ step10
•Show ⍷step10
•Show ≠¨⊐⊸⊔ step10
#(⌈´-⌊´) ≠¨⊐⊸⊔ step10

#part 2
•Show input
#transform input values to indices instead
nl←((0‿2⊸⊏⋈2‿1⊸⊏)∾)˘input
keys ← ⊏˘input
•Show indices ← ((keys⊸⊐⊏)≍(keys⊸⊐1⊸⊏))˘nl
•Show pIn1 ← (>⊏˘input)∊2↕template

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
•Show Fn3⍟9 pIn1

•Show "counterArr"
•Show ≠counterArr

•Show elements ← 1⊏˘input
•Show k←⊐elements

•Show (+´)¨k⊔counterArr

•Show uniq←⍷elements
t←(⊑≍≠)¨⊐⊸⊔ template
•Show initC←+˝t{(⊑𝕨)≡⊑𝕩?1⊑𝕨;0}⌜uniq

(⌈´-⌊´)initC+(+´)¨k⊔counterArr

# for after step 10
#"HFBVOPNCSK"
#⟨ 3978 2711 1490 3056 570 2643 2082 972 577 1378 ⟩

