from idris question here https://groups.google.com/forum/#!topic/idris-lang/-tmOaux6DFI

# homogeneous (=), propositional equality in haskell (:~:)

```idr
-- proudo-definition, primary operation
data (=) : a -> b -> Type where
  refl : x = x
```

inhabited by some terminating value

alike

```idr
*src/15_EqualityConstraint_Twice_class> :doc (=)
Data type (=) : (x : A) -> (y : B) -> Type
    The propositional equality type. A proof that x = y.

    To use such a proof, pattern-match on it, and the two equal things will then need to be the same pattern.

    Note: Idris's equality type is potentially heterogeneous, which means that it is possible to state equalities
    between values of potentially different types. However, Idris will attempt the homogeneous case unless it
    fails to typecheck.

    You may need to use (~=~) to explicitly request heterogeneous equality.
    Arguments:
        (implicit) A : Type  -- the type of the left side of the equality

        (implicit) B : Type  -- the type of the right side of the equality

Constructors:
    Refl : x = x
        A proof that x in fact equals x. To construct this, you must have already shown that both sides are in fact
        equal.
        Arguments:
            (implicit) A : Type  -- the type at which the equality is proven

            (implicit) x : A  -- the element shown to be equal to itself.
```

in haskell

```hs
data a :~: b where  -- See Note [The equality types story] in TysPrim
  Refl :: a :~: a
```

# heterogeneous (~=~), lifted eq in haskell (~~)

diverse in character or content

By lifted, we mean that it can be bogus (deferred type error). By heterogeneous, the two types a and b might have different kinds

in idris

```idr
Idris> :doc (~=~)
(~=~) : (x : a) -> (y : b) -> Type
    Explicit heterogeneous ("John Major") equality. Use this when Idris incorrectly chooses homogeneous equality
    for (=).
    infix 5
    Arguments:
        (implicit) b : Type  -- the type of the right side

        (implicit) a : Type  -- the type of the left side

        x : a  -- the left side

        y : b  -- the right side

    The function is Total
```

in haskell

```
class a ~~ b => (a :: k) ~ (b :: k)
-- no body
```
