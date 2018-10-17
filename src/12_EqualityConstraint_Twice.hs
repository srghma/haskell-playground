module Main where

import Prelude

-- https://stackoverflow.com/a/11554793/3574379

twice1 :: (b -> b) -> b -> b
twice1 f = f . f

transform :: Int -> Int
transform n = n + 1

apply1 :: Int -> Int
apply1 = twice1 transform
