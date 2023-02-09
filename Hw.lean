/-
For this homework, we will talk about equivalence relations. 
These are relations `R : α → α → Prop` which are 
- reflexive
- symmetric : ∀ a a', R a a' → R a' a 
- transitive 
-/

#print Equivalence 

/- 
The most common equivalence relation is equality but can be 
made in many other ways. 
-/

/-- Two strings are related if they have the same length -/ 
def EqLen (s t : String) : Prop := s.length = t.length 

/-- We use the notation \sim for `EqLen` -/
infixl:60 " ∼ " => EqLen 

example : Equivalence EqLen := by 
  have refl : ∀ (s : String), s ∼ s := sorry 
  have symm : ∀ { s s' : String }, s ∼ s' → s' ∼ s := sorry 
  have trans : ∀ { s t u : String }, s ∼ t → t ∼ u → s ∼ u := sorry 
  exact ⟨refl,symm,trans⟩ 

/-
Instead of filling the `sorry`'s here we will note that this is part 
of a more general pattern. Given a type `α` and a function `f : α → β`, 
the relation a ∼ a' if and only if f a = f a' is an equivalence 
relation. 
-/

variable {α β : Type} (f : α → β) 

def QuotRel (a a' : α) : Prop := f a = f a'

notation:65 x:65 " ∼ " y:65 " mod " z:65 => QuotRel z x y 

theorem quotRel_refl (a : α) : a ∼ a mod f:= sorry 

theorem quotRel_symm (a a' : α) (h : a ∼ a' mod f) : a' ∼ a mod f := sorry 

theorem quotRel_trans (a₁ a₂ a₃ : α) (h₁ : a₁ ∼ a₂ mod f) (h₂ : a₂ ∼ a₃ mod f) 
    : a₁ ∼ a₃ mod f := sorry 

/- For this one, Lean can get confused between `(a : α)` and `{a : α}` in 
arguments. Suppose we have a `F : ∀ {a : α}, ...`. Then `@F` foces you to 
supply `a` in the argument. Conversely if you believe Lean should be able 
"to figure it out" for a particular argument you can use a underscore `_` -/
theorem quotRel_equiv : Equivalence (· ∼ · mod f) := sorry 

/- 
Given an equivalence relation, it is natural to consider its equivalence 
classes. We can do that using subtypes. 
-/

/-- `Cl R a` should be read as the type whose terms are terms `(a':α)` 
which satisfy `R a' a` -/
def Cl {α : Type} (R : α → α → Prop) (a : α) : Type := { a' : α // R a' a }

/- Given `(a' : Cl R a)` you can access the underlying term of type `α` 
as `a'.val` and the proof of `R a'.val a` as `a'.property`-/

#print Subtype

/- All strings of length 4 -/
#check Cl EqLen "Lean"

variable (R : α → α → Prop) (h : Equivalence R) 

/- If two equivalence classes share an element, then they coincide -/
theorem cl_disjoint (a₁ a₂ : α) (a : Cl R a₁) (a' : Cl R a₂) (h : a.val = a'.val) 
    : a₁ = a₂ := sorry 
