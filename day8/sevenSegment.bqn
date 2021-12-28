rawInput ← •file.Lines "inputTest"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

input ← >(' '⊸FSplitString)∘(1⊸↓)∘(1⊸⊑)∘('|'⊸FSplitString)¨ rawInput
signal ← >(' '⊸FSplitString)∘⊑∘('|'⊸FSplitString)¨ rawInput

#number segments
#1      2
#4      4
#7      3
#8      7

# part 1
FCheckInstances ← {+´⥊𝕨=⌜𝕩}
+´2‿4‿3‿7⊸FCheckInstances˘≠¨input

## default encoding
# a,b,c,d,e,f,g
# 0,1,2,3,4,5,6
# below are all the digits encodings
digit1 ← ⟨0,0,1,0,0,1,0⟩
digit4 ← ⟨0,1,1,1,0,1,0⟩
digit7 ← ⟨1,0,1,0,0,1,0⟩
digit8 ← ⟨1,1,1,1,1,1,1⟩

digit2 ← ⟨1,0,1,1,1,0,1⟩
digit3 ← ⟨1,0,1,1,0,1,1⟩
digit5 ← ⟨1,1,0,1,0,1,1⟩

digit0 ← ⟨1,1,1,0,1,1,1⟩
digit6 ← ⟨1,1,0,1,1,1,1⟩
digit9 ← ⟨1,1,1,1,0,1,1⟩

# how to find non-intersection of w
# "dab"(¬∘∊/⊣)"ab"
#"d"
# "aceg"(¬∘∊/⊣)"dgea"
#"c"
#   "ceg"(¬∘∊/⊣)"dgea"
#"c"
#   "ceg"(¬∘∊/⊣)"dgec"
#⟨⟩

# for 1st e.g. if found the encoding is "deafgbc" 
# or ⟨3,4,0,5,6,1,2⟩
# to get the encoding for digit 3
# ⟨1,0,1,1,0,1,1⟩/⟨3,4,0,5,6,1,2⟩ = ⟨ 3 0 5 1 2 ⟩ 
# which is dafbc

# order signal by character length
•Show signal ↩ (⍋˘≠¨)⊸(⊏˘)signal

# first step - from digit 1(2) and 7(3), find out 'a' (code 0)
#encoding ← (1⊑˘signal)(¬∘∊/⊣)˘(⊑˘signal)
•Show encoding ← (1⊸⊑(¬∘∊/⊣)⊑)˘signal

# step 2 - get the ones with 6 characters - potential digit 6,9 or 0
# find out - 'c' (code 2) and 'f' (code 5)
({2=≠¨⊐⊸⊔𝕩}/⍷)∘∾∘(6‿7‿8⊸⊏)˘ signal

# example
#   c←∾"cbdgef"‿"fgaecd"‿"agebfd"
#"cbdgeffgaecdagebfd"
#   (2=≠¨⊐⊸⊔c)/(⍷c)
#"cba"
#   ({2=≠¨⊐⊸⊔𝕩}/⍷) c
#"cba"




