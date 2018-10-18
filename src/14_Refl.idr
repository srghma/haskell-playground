module Main

-- from http://docs.idris-lang.org/en/latest/tutorial/theorems.html?highlight=fiveIsFive#equality

-- = is defined in sourse code of idris
-- https://groups.google.com/forum/#!topic/idris-lang/-tmOaux6DFI

-- proudo-definition
-- data (=) : a -> b -> Type where
--   refl : x = x

fiveIsFive : 5 = 5
fiveIsFive = Refl

twoPlusTwo : 2 + 2 = 4
twoPlusTwo = Refl

--- (=) defined ourselves

using (a : Type, b : Type, x : a)
  data Equus : a -> b -> Type where
    --  will raise error `Main.eqRefl has a name which may be implicitly bound.`
    --  implicitly bound variable - implicit forall

    -- eqRefl : Equus x x

    EqRefl : Equus x x -- right definition

twoPlusTwo' : 2 + 2 `Equus` 4
twoPlusTwo' = EqRefl
