module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)

twice1 :: forall t1 t2. Semigroupoid t2 => t2 t1 t1 -> t2 t1 t1
twice1 f = f >>> f

transform :: Int -> Int
transform n = n + 1

apply1 :: Int -> Int
apply1 x = twice1 transform x

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = logShow $ apply1 1
