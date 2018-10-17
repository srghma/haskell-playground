module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String
import Data.Show
import Data.Show
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)

newtype Composition f g a = Composition (f (g a))
infixr 9 type Composition as ○

-- either this

-- instance compositionShow :: (Show (f (g a))) => Show (Composition f g a) where
--   show (Composition fga) = "(Composition " <> (show fga) <> ")"

-- or this

derive instance genericComposition :: Generic (Composition f g a) _

instance showComposition :: Show (f (g a)) => Show (Composition f g a) where
  show = genericShow

newtype Apply f a = Apply (f a)
infixr 0 type Apply as ↯

derive instance genericApply :: Generic (Apply f a) _

instance showApply :: Show (f a) => Show (Apply f a) where
  show = genericShow

test :: Array (Maybe Int)
test = [Just 1]

test2 :: (Array ○ Maybe) Int
test2 = Composition [Just 1]

test3 :: Array ○ Maybe ↯ Int
test3 = Apply (Composition [Just 1])

test4 :: (Array ○ Maybe ○ Maybe) Int
test4 = Composition [Composition (Just (Just 1))]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  logShow test
  logShow test2
  logShow test3
  logShow test4
  log "Hello, World!"
