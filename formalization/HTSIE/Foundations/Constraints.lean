theorem constraint_monotone_can_fail :
    ∃ (X : FinStateSpace) (sys : FinConstraintSystem X),
    ¬ ConstraintMonotone sys := by
  have h_nonempty : ({1, 2, 3, 4, 5} : Finset ℕ).Nonempty := ⟨1, by decide⟩
  let X : FinStateSpace := ⟨{1, 2, 3, 4, 5}, h_nonempty⟩
  let sys : FinConstraintSystem X := {
    accessibility := fun n => if n + 1 ∈ ({1, 2, 3, 4, 5} : Finset ℕ) then {n + 1} else ∅
    accessible_subset := by
      intro c
      dsimp
      split_ifs with h
      · exact Finset.singleton_subset_iff.mpr h
      · exact Finset.empty_subset _
  }
  refine ⟨X, sys, ?_⟩
  intro h
  have h12 : (1 : ℕ) ≤ 2 := by norm_num
  have hsub := h 1 2 h12
  dsimp [sys] at hsub
  have h3_in : (3 : ℕ) ∈ ({3} : Finset ℕ) := Finset.mem_singleton_self 3
  have h3_in_2 : (3 : ℕ) ∈ ({2} : Finset ℕ) := hsub h3_in
  revert h3_in_2
  decide
