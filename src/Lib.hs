module Lib where

import Data.Aeson.TH as Aeson
import Protolude

data Freeplay = Freeplay
  { freeplay :: !Bool
  , operator :: !Text
  , token    :: !Text
  , site     :: !Text
  }

$(Aeson.deriveJSON Aeson.defaultOptions ''Freeplay)

data AuthRequest = AuthRequest
  { cmd        :: !Text
  , gameId     :: !Text
  , launchVars :: Freeplay
  }

$(Aeson.deriveJSON Aeson.defaultOptions ''AuthRequest)
