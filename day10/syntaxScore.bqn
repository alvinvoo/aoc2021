input ← •file.Lines "input"

scores ← ⟨')'‿3, ']'‿57, '}'‿1197, '>'‿25137⟩
matchingBrackets ← ⟨"()", "[]", "{}", "<>"⟩
revMB ← ⌽¨matchingBrackets

FGetDict ← ⊑⊑¨∘=/⊣

# usage
#scores FGetDict ']'
#scores FGetDict '>'
#revMB FGetDict '>'

# part 1
FOneLine ← {
  stack ← ⟨⟩
  ret ← {⊑𝕩∊"[({<" ? stack↩𝕩∾stack⋄@ 
    ; (1⊑ (revMB FGetDict 𝕩))≡⊑stack ? stack↩1↓stack⋄@ ; 
    𝕩}¨𝕩
  @ (≠/⊢) ret
}

illegals ← FOneLine¨ input
justFirstOnes ← (1↑¨0⊸<∘≠¨/⊢) illegals

+´1⊑¨{scores FGetDict ⊑𝕩}¨justFirstOnes

# part 2
incompleteLines ← ((0⊸=∘≠¨) illegals)/input
inCount ← ≠incompleteLines

FOneLine2 ← {
  stack ← ⟨⟩
  {⊑𝕩∊"[({<" ? stack↩𝕩∾stack
    ; (1⊑ (revMB FGetDict 𝕩))≡⊑stack ? stack↩1↓stack}¨𝕩
  stack
}

# use the opening brackets as scores
revScores ← ⟨'('‿1, '['‿2, '{'‿3, '<'‿4⟩
openMatches ← FOneLine2¨ incompleteLines

# can refactor to using FOLD
FCountScore ← {
  totalScore ← 0
  { 
    newScore ← 5 × totalScore ⋄
    addScore ← 1⊑revScores FGetDict 𝕩 ⋄
    totalScore ↩ newScore + addScore
  }¨𝕩
  totalScore
}

(2÷˜1-˜inCount)⊑∧FCountScore¨ openMatches




