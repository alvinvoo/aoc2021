in ← •FLines "inputEx1"
do ← •ReBQN {repl⇐"strict"}
# input conversion

Convert ← {
  ss←/'['=𝕩
  se←/']'=𝕩
  ('⟩'⥊˜≠se)⌾(se⊸⊏) ('⟨'⥊˜≠ss)⌾(ss⊸⊏) 𝕩
}

in ↩ {Do Convert 𝕩}¨in

# addition
Add←∾○<

# for Ex1 only
fin ⇐ (⊑in) Add (1⊑in)

{•Show "e" ⋄ •Show 𝕩}⚇¯4 fin
# those with depth ≥ 5, need to explode the first encountered array
#   {•Show "e" ⋄ •Show 𝕩}⚇¯4 ⟨⟨⟨⟨⟨9,8⟩,1⟩,2⟩,3⟩,4⟩           
#   "e"
#   ⟨ 9 8 ⟩ # ≡= 2
#   "e"
#   1
#   "e"
#   2
#   "e"
#   3
#   "e"
#   4


