{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies      #-}

module Main where

import           Protolude

-- https://stackoverflow.com/a/11554793/3574379
class Twice1 f where
  twice1 :: f -> f

class Twice2 f where
  twice2 :: f -> f

instance Twice1 (a -> a) where
  twice1 f = f . f

instance (a ~ b) => Twice2 (a -> b) where
  twice2 f = f . f

class Example a where
  transform :: Int -> a

instance Example Int where
  transform n = n + 1

instance Example Char where
  transform _ = 'x'

-- raise error ambiguous type
-- apply1 :: Int -> Int -- add this line to resolve error
-- apply1 = twice1 transform

-- derives type apply2 :: Int -> Int automatically
apply2 = twice2 transform

main :: IO ()
main = return ()
