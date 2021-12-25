input ← •file.Lines "inputTest"

#   ' '((⊢-˜¬×+`)∘=⊔⊢)"0,9 -> 5,9"
#⟨ "0,9" "->" "5,9" ⟩
FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
a←' 'FSplitString¨ input

FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')
#    ((FSplitString˜⟜',' ⊑)⋈(FSplitString˜⟜',' ¯1⊸⊑)) b
# ⟨ ⟨ "0" "9" ⟩ ⟨ "5" "9" ⟩ ⟩
# --- or ---
#   (FSplitString˜⟜',')¨(⊑⋈¯1⊸⊑) b
#⟨ ⟨ "0" "9" ⟩ ⟨ "5" "9" ⟩ 
input ↩ >(FStringToInt⚇¯1∘FSplitString˜⟜','¨(⊑⋈¯1⊸⊑))¨ a

#solution 1 - only consider vertical and horizontal lines

VertHorCoorFilter ← {0=×´-´𝕩}
onlyVertHorCoor ← ∧˘VertHorCoorFilter˘⊸/ input


#find default zeroTable size
maxCoor ← 1+⌈´∾´⥊onlyVertHorCoor
zeroTable ← maxCoor‿maxCoor⥊0

## vertical 2,2 -> 2,1
#   ⍉(0»⍟1 1»⍟2 10⥊0)⌾(2⊸⊏)zeroTable
#┌─                     
#╵ 0 0 0 0 0 0 0 0 0 0  
#  0 0 1 0 0 0 0 0 0 0  
#  0 0 1 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#                      ┘
#
## horizontal 0,9 -> 5,9
#   (0»⍟0 1»⍟5 10⥊0)⌾(9⊸⊏)zeroTable
#┌─                     
#╵ 0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  0 0 0 0 0 0 0 0 0 0  
#  1 1 1 1 1 0 0 0 0 0  
#                      ┘
#horizontal line = 1, vertical line = 0
grouping←{x‿y←𝕩⋄y=0}∘-´˘ onlyVertHorCoor

verticalGroup ← 0⊑grouping⊔onlyVertHorCoor
horizontalGroup ← 1⊑grouping⊔onlyVertHorCoor

## solution 1
#FConvertTableVert ← {⟨x1‿y1,x2‿y2⟩←𝕩⋄len←1+y2-y1⋄⍉(0»⍟y1 1»⍟len maxCoor⥊0)⌾(x1⊸⊏)zeroTable}
#FConvertTableHor ← {⟨x1‿y1,x2‿y2⟩←𝕩⋄len←1+x2-x1⋄(0»⍟x1 1»⍟len maxCoor⥊0)⌾(y1⊸⊏)zeroTable}
#
#vertTable ← FConvertTableVert˘ verticalGroup 
#horTable ← FConvertTableHor˘ horizontalGroup 
#
#resTable ← +˝vertTable ∾ horTable
#•Show +´2⊸≤⥊resTable


#solution 2 - consider vertical, horizontal and exact diagonal lines
DiagonalCoorFilter ← {0=-´|-´𝕩}
# after refactoring, to check for all valid cases
#   ¬((-´∘| × ×´) -´)˘input
#⟨ 1 1 1 1 1 1 1 1 1 1 ⟩

allCoors ← (¬((-´∘| × ×´) -´))˘⊸/ input




