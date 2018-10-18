module Main

import Prelude

-- https://stackoverflow.com/a/11554793/3574379

interface Twice f where
  twice : f -> f

Twice (a -> a) where
  twice f = f . f

interface Example a where
  transform : Int -> a

Example Int where
  transform n = n + 1

Example Char where
  transform _ = 'x'

-- run in REPL to see that it derives properly:

-- $ idris src/15_EqualityConstraint_Twice_class.idr
-- *src/15_EqualityConstraint_Twice_class> :t twice transform
-- twice transform : Int -> Int

-- Summary:
-- in idris you dont need equality constaint to derive type of such functions properly
