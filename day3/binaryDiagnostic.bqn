
input ← •file.Lines "input"

input ↩ -⟜'0'¨>input
#solution 1
gammaRate ← (2÷˜≠input)≥˜+˝input
epsilonRate ←  ¬gammaRate

•Show gammaRate
•Show epsilonRate

#gb ← +´(⌽2⋆↕≠gammaRate) × gammaRate
#eb ← +´(⌽2⋆↕≠epsilonRate) × epsilonRate
#•Show gb × eb
# after refactored
# convert from binary to decimal
#   +´(⊢×(⌽2⊸⋆∘↕∘≠)) gammaRate
#9

FConvert ← +´(⊢×(⌽2⊸⋆∘↕∘≠))
•Show (FConvert×FConvert∘¬) gammaRate

# self recursive function?
# refactor gammaRate
# (2÷˜≠input)>˜+˝input
#   (+˝>÷⟜2∘≠)input
#⟨ 1 0 1 1 0 ⟩

FGetGamma ← +˝≥÷⟜2∘≠
FGetEpsilon ← ¬FGetGamma

#   (1=⊑˘input)
#⟨ 0 1 1 1 1 0 0 1 1 1 0 0 ⟩
#   (1=⊑˘input) / input
#┌─           
#╵ 1 1 1 1 0  
#  1 0 1 1 0  
#  1 0 1 1 1  
#  1 0 1 0 1  
#  1 1 1 0 0  
#  1 0 0 0 0  
#  1 1 0 0 1  
#            ┘
# with FGetGamma
#   ((⊑FGetGamma input)=⊑˘input) / input
#┌─           
#╵ 1 1 1 1 0  
#  1 0 1 1 0  
#  1 0 1 1 1  
#  1 0 1 0 1  
#  1 1 1 0 0  
#  1 0 0 0 0  
#  1 1 0 0 1  
#            ┘
FG ← {(𝕨⊑˘𝕩=𝕨⊑FGetGamma 𝕩) / 𝕩}
FE ← {(𝕨⊑˘𝕩=𝕨⊑FGetEpsilon 𝕩) / 𝕩}

RecurFG ← {
  newInput ← 𝕨 FG 𝕩 # if 𝕨 is not provided, its implied as zero
  1⊸<∘≠◶⊏‿((𝕨+1)⊸𝕊) newInput
}

•Show RecurFG input

RecurFE ← {
  1⊸<∘≠◶⊏‿((𝕨+1)⊸𝕊) 𝕨 FE 𝕩
}

•Show RecurFE input

•Show (FConvert ∘ RecurFE×FConvert ∘ RecurFG) input

