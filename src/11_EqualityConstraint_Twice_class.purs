module Main where

import Prelude

-- copied from https://github.com/purescript/purescript-type-equality/blob/master/src/Type/Equality.purs
class TypeEquals a b | a -> b, b -> a where
  to :: a -> b
  from :: b -> a

instance refl :: TypeEquals a a where
  to a = a
  from a = a

-----------------

class Twice1 f where
  twice1 :: f -> f

class Twice2 f where
  twice2 :: f -> f

instance mytwice1 :: Twice1 (a -> a) where
  twice1 f = f >>> f

instance mytwice2 :: TypeEquals a b => Twice2 (a -> b) where
  twice2 f = f >>> from >>> f

class Example a where
  transform :: Int -> a

instance exampleInt :: Example Int where
  transform n = n + 1

instance exampleChar :: Example Char where
  transform _ = 'x'

{--
-- will raise error
--   No type class instance was found for Main.Twice1 (Int -> t1)

apply1 x = twice1 transform x

-- to resolve error add type declaration
apply1 :: Int -> Int

--}

-- compiles without error and manual type declaration, has type Int -> Int automatically
apply2 x = twice2 transform x
