
inputNumbers ← •file.Lines "inputNumbers"
inputBoards ← •file.Lines "inputBoards"

# Dealing with input
# convert from ⟨ "7,4,9,5,11,17,23,2,...⟩
#','((⊢-˜¬×+`)∘=⊔⊢)⊑inputNumbers
#⟨ "7" "4" "9" "5" "11" "17" "23" "2" ...⟩
FConvertInputWholeString ← ','⊸((⊢-˜¬×+`)∘=⊔⊢)⊑ 
FConvertFromStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

inputNumbers↩FConvertFromStringToInt¨ FConvertInputWholeString inputNumbers

# How to group inputBoards? 
#
#   ((3⥊5)/↕3)⊔>(¬(⟨⟩⊸≡)¨ inputBoards) / inputBoards
#┌─                                                          
#· ┌─                 ┌─                 ┌─                  
#  ╵"22 13 17 11  0   ╵" 3 15  0  2 22   ╵"14 21 17 24  4    
#     8  2 23  4 24      9 18 13 17  5     10 16 15  9 19    
#    21  9 14 16  7     19  8  7 25 23     18  8 23 26 20    
#     6 10  3 18  5     20 11 10 24  4     22 11 13  6  5    
#     1 12 20 15 19"    14 21 16 12  6"     2  0 12  3  7"   
#                   ┘                  ┘                  ┘  
#                                                           ┘
# some refactoring
# ((3⥊5)/↕3) ⊔ >(¬⟨⟩⊸≡¨) ⊸/ inputBoards
# (⥊(5⥊1)×⌜˜↕3) ⊔ >(¬⟨⟩⊸≡¨) ⊸/ inputBoards

FGetBoardGroups ← {
  # ⟨ "22 13 17 11  0" " 8  2 23  4 24" "21  9 14 16  7"  ...⟩
  # removed ⟨⟩, but still contains multiple spaces and strings
  d2boards ← (¬⟨⟩⊸≡¨) ⊸/ 𝕩
  # ⟨ ⟨ "22" "13" "17" "11" "0" ⟩ ⟨ "8" "2" "23" "4" "24" ⟩ ⟨ "21" "9" "14" "16" # "7" ⟩... ⟩
  cD2Boards ← ((¬⟨⟩⊸≡¨) ⊸/ ' '⊸((⊢-˜¬×+`)∘=⊔⊢))¨ d2boards
  # convert all strings to ints, and stand them up in 2D
  # ─                
#		╵ 22 13 17 11  0  
#		   8  2 23  4 24  
#		  21  9 14 16  7 
#     ...
  allIntsBoard ← >(+´((⌽10⋆↕∘≠)×-⟜'0'))⚇1 cD2Boards
# grouped 
	(⥊(5⥊1)×⌜˜↕(5÷˜≠)allIntsBoard) ⊔ allIntsBoard 
}

groupedIntsBoard ← FGetBoardGroups inputBoards

#Solution 1
# self recursively compare-each and add
#   (1=¨d5)+(6=¨d5)+(21=¨d5)+(8=¨d5)+22=¨d5
#┌─                                           
#· ┌─            ┌─            ┌─             
#  ╵ 1 0 0 0 0   ╵ 0 0 0 0 1   ╵ 0 1 0 0 0    
#    1 0 0 0 0     0 0 0 0 0     0 0 0 0 0    
#    1 0 0 0 0     0 1 0 0 0     0 1 0 0 0    
#    1 0 0 0 0     0 0 0 0 0     1 0 0 1 0    
#    1 0 0 0 0     0 1 0 0 1     0 0 0 0 0    
#              ┘             ┘             ┘  
#                                            ┘
#  and check ALL column wise
#   ∧˝¨(1=¨d5)+(6=¨d5)+(21=¨d5)+(8=¨d5)+22=¨d5 
#⟨ ⟨ 1 0 0 0 0 ⟩ ⟨ 0 0 0 0 0 ⟩ ⟨ 0 0 0 0 0 ⟩ ⟩
#  flip check 
#   ∧˝∘⍉¨(1=¨d5)+(6=¨d5)+(21=¨d5)+(8=¨d5)+22=¨d5 
#⟨ ⟨ 0 0 0 0 0 ⟩ ⟨ 0 0 0 0 0 ⟩ ⟨ 0 0 0 0 0 ⟩ ⟩
#  check ANY once to know WHICH board has Bingo
#   ∨´¨∧˝∘⍉¨(0=¨d5)+(11=¨d5)+(17=¨d5)+(13=¨d5)+22=¨d5
#⟨ 1 0 0 ⟩
#  check ANY twice to know if any Bingo
#   (∨´)⍟2∧˝∘⍉¨(0=¨d5)+(11=¨d5)+(17=¨d5)+(13=¨d5)+22=¨d5
#1
FGetBingo ← {
  searchedNum ← 𝕨⊑inputNumbers
  newBoard ← 𝕩+ searchedNum⊸=¨ groupedIntsBoard 
  checkVert ← (∨´¨∧˝¨) newBoard
  anyHor ← ∨´ checkVert
  checkHor ← (∨´¨∧˝∘⍉¨) newBoard
  anyVert ← ∨´ checkHor 

  (⊑anyHor‿anyVert⊐1)◶⟨"vert"‿searchedNum‿newBoard‿checkVert⟩‿⟨"hor"‿searchedNum‿newBoard‿checkHor⟩‿((𝕨+1)⊸𝕊) newBoard
}
bingoStruct ← FGetBingo 0
a‿n‿m‿c ← ⊑bingoStruct
•Show c ⊑∘/ groupedIntsBoard
•Show c ⊑∘/ m
# reverse
•Show ¬∘⊑∘/⟜ m c

•Show unmarkedNumbers ← +´⥊(⊑∘/⟜groupedIntsBoard × ¬∘⊑∘/⟜m) c
•Show unmarkedNumbers × n


# solution 2

# mapped them instead
markedBoards ← inputNumbers =⌜ groupedIntsBoard
# scan them row-wise
allBoards ← +`⎉2 markedBoards
# check for Vertical hits
t1 ← ∨´¨∧˝¨allBoards
# check for Horizontal hits
t2 ← ∨´¨∧˝∘⍉¨allBoards

winIndAllBoards ← ⌊´(⊑/)˘∘⍉¨t1‿t2
inputNumberInd ← ⌈´winIndAllBoards
boardInd ← ⊑winIndAllBoards ⊐ inputNumberInd

unmarkedMask ← ¬inputNumberInd⊑boardInd⊏˘allBoards

board ← boardInd⊑groupedIntsBoard

•Show (inputNumberInd⊑inputNumbers) × +´⥊unmarkedMask × board
