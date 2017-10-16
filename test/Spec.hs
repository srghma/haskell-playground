module Main where

import           Data.Aeson as Aeson
import           Lib
import           Protolude
import           Test.Hspec

main :: IO ()
main =
  hspec $ do
    describe "BASE" $ do
      it "can get session" $ do
        let req =
              AuthRequest
              { cmd = "AUTH"
              , gameId = "68757968-75796875-79687579-68757968"
              , launchVars =
                  Freeplay
                  { freeplay = True
                  , operator = "5e41c28d-e372-4d12-90bb-afbf6ee31cee"
                  , token = "test_token2"
                  , site = "test_site"
                  }
              }
        Aeson.encode req `shouldBe`
          "{\"cmd\":\"AUTH\",\"gameId\":\"68757968-75796875-79687579-68757968\",\"launchVars\":{\"freeplay\":true,\"operator\":\"5e41c28d-e372-4d12-90bb-afbf6ee31cee\",\"token\":\"test_token2\",\"site\":\"test_site\"}}"
