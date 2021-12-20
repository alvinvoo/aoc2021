
input ← •file.Lines "input"

#Convert a "character" list to a number: "2097" -> 2097
# +´(10⋆⌽↕4) × 2‿0‿9‿7
#2097
Convert ← {
  +´(10⋆⌽↕≠𝕩) × ("0"⊸∾⍟(≠𝕩) ⟨⟩) -˜ 𝕩
}

input↩Convert¨ input

# Solution 1
•Show 1-˜+´>⟜0¨-⟜» input

# Solution 2
•Show 1-˜+´>⟜0¨-⟜» +˝˘3↕input
