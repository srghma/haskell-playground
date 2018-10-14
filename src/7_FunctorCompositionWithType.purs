module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)

type Composition f g a = f (g a)
infixr 9 type Composition as ○

type Apply f a = f a
infixr 0 type Apply as ↯

test1 :: (Array ○ Maybe) Int
test1 = [Just 1]

test2 :: Array ○ Maybe ↯ Int
test2 = [Just 1]

test3 :: (Array ○ Maybe ○ Maybe) Int
test3 = [Just (Just 1)]

test4 :: Array ○ Maybe ○ Maybe ↯ Int
test4 = [Just (Just 1)]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  logShow test1
  logShow test2
  logShow test3
  logShow test4
