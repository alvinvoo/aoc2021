
•Show input ← •file.Lines "inputTest"
•SHow template ← ⊑•file.Lines "templateTest"

FSplitString ← (⊢-˜¬×·+`1⊸»<⊢)∘∊˜⊔⊢

•Show input ↩ >{" -> "FSplitString 𝕩}¨input

# how to get key-value
a ← "NN"{1⊑⊏(𝕨⊸≡¨⊏˘)⊸/𝕩}input
