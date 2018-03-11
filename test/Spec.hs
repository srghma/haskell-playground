module Main where

import           Protolude
import           Test.Hspec

import           Mtl

main :: IO ()
main =
  hspec $ do
    it "check password" $ do
      right_password `shouldBe` "secret"
