module Main where

import qualified GHC.Show                      as Show
import           Protolude

-- for https://www.reddit.com/r/haskell/comments/61qm78/understanding_instance_resolution_and_constraints/dfiyimd
data MyTuple a b =
  MyTuple a
          b

-- instance Show (MyTuple a b) where -- error
--   show _ = "MyTuple <some value> <some value>"

instance (Show a, Show b) => Show (MyTuple a b) where
  show (MyTuple a b) = "MyTuple " ++ show a ++ " " ++ show b

main :: IO ()
main = print (MyTuple 1 "2" :: MyTuple Int Text)
