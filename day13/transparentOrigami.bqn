
input ← •file.Lines "input"
fold ← •file.Lines "fold"

FSplitString ← ((⊢-˜¬×+`)∘=⊔⊢)
FStringToInt ← +´((⌽10⋆↕∘≠)×-⟜'0')

•Show input ↩ >FStringToInt⚇¯2 ','FSplitString¨input

•Show fold ↩ {a‿b←'='FSplitString ¯1⊑' 'FSplitString𝕩⋄a‿(FStringToInt b)}¨fold

# assuming all fold lines are always in half of the paper

Fn ← {
# first get 2nd half of the paper
axis‿line←𝕨

# which fold?
wf←{axis≡"y"?1;0}
# experimental, flip x,y according to the fold axis
# so the folding algo doesnt need to change

# if "y" fold
# first half
fh←line>wf⊏˘𝕩
firstHalf ← fh/𝕩
# 2nd half
wfunc←{axis≡"y"?{x‿y←𝕩⋄x‿(y-˜line×2)};{x‿y←𝕩⋄(x-˜line×2)‿y}}
afterFold ← wfunc˘(¬fh)/𝕩

⍷ firstHalf ∾ afterFold
}

# part 1
#i←(⊏fold) Fn input
#≠i

# part 2

•Show "part 2"
accum ← input
code←∧¯1⊑{
  accum↩𝕩Fn accum
}¨fold

# size is 39 × 6
⍉39‿6⥊code∊˜>⥊↕39‿6
# CAFJHZCK
