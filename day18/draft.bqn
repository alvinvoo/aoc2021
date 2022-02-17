
#sum←"[[[[0,7],4],[15,[0,13]]],[1,1]]"
sum←"[[[[0,70],423],[15,[0,13]]],[1,1]]"

#sum←"[[[[4,3],4],4],[7,[[8,4],9]]]"

#non numbers selectors
bs←"[],"=˘sum∾≍˜sum
#numbers selector
ns←¬+˝bs

#trimmed set

d←(⊢-˜¬×·+`1⊸»<⊢)(¬ns)
•Show grouped_n←d⊔sum

rfd←ns-(1⊸»<⊢)ns
•Show trimed←(¬rfd)/sum

tbs←"[],"=˘trimed∾≍˜trimed
•Show tns←¬+˝tbs
•Show dtns←/tns
•Show g←grouped_n⌾((/tns)⊸⊏)trimed
•Show ga←{1=≡𝕩?𝕩;⟨(/𝕩="[],")⊑"⟨⟩,"⟩}¨g


