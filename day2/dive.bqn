
input ← •file.Lines "input"

SplitBySpace ← {
  ' '((⊢-˜¬×+`)∘=⊔⊢) 𝕩
}

input ↩ SplitBySpace¨input

# if can first extract them into 3 lists
#({"forward"≡⊑𝕩}¨input) / input

#solution 1
forwardList ← {"forward"≡⊑𝕩}¨⊸/input
downList ← {"down"≡⊑𝕩}¨⊸/input
upList ← {"up"≡⊑𝕩}¨⊸/input

forwardTotal ← ⊑+˝'0'-˜1⊑˘>forwardList
downTotal ← ⊑+˝'0'-˜(1⊑˘>downList)
upTotal ← ⊑+˝'0'-˜(1⊑˘>upList)

•Show forwardTotal × (downTotal - upTotal)

#cannot split and group the list, need to process in order
#solution 2

horizontalDiff ← ({"forward"≡⊑𝕩}◶0‿{⊑'0'-˜1⊑𝕩})¨input

# get the index of
#{⟨"forward","down","up"⟩ ⊸⊐⌾< (⊑𝕩)}  "forward"‿5
#0

aimScan ← +`({⟨"down","up"⟩ ⊸⊐⌾< ⊑𝕩}◶{⊑'0'-˜1⊑𝕩}‿{-⊑'0'-˜1⊑𝕩}‿0)¨input
depthScan ← +`horizontalDiff × aimScan

•Show forwardTotal×⊑⌽depthScan

