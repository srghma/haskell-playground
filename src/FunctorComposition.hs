-- https://stackoverflow.com/questions/52791746/how-to-make-dot-composition-and-dollar-application-sign-for-functors
-- https://stackoverflow.com/questions/4922560/why-doesnt-typesynonyminstances-allow-partially-applied-type-synonyms-to-be-use
-- https://ocharles.org.uk/posts/2014-12-08-type-operators.html

{-# LANGUAGE TypeOperators #-}

module Main where

import Protolude

-- I can't use `type` here, because type synonyms cannot be partially applied
--
-- i.e. can't compile with
-- infixr 9 ○
-- type (○) f g a = f (g a)
-- infixr 0 ↯
-- type (↯) f a = f a

-- composition of functors, analog of .
infixr 9 ○
newtype (○) f g a = Composition (f (g a)) deriving (Show)

-- functor application, analog of $
infixr 0 ↯
newtype (↯) f a = Apply (f a) deriving (Show)

test :: [] (Maybe Int)
test = [Just 1]

test2 :: ([] ○ Maybe) Int
test2 = Composition [Just 1]

test2' :: [] ○ Maybe ↯ Int
test2' = Apply (Composition [Just 1])

test3 :: ([] ○ Maybe ○ Maybe) Int
test3 = Composition [Composition (Just (Just 1))]

test3' :: [] ○ Maybe ○ Maybe ↯ Int
test3' = Apply (Composition [Composition (Just (Just 1))])

main :: IO ()
main = do
  print test
  print test2
  print test2'
  print test3
  print test3'
  return ()
