{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module Foo where

import Protolude
import Data.Type.Equality

homo :: Int :~: Int
homo = Refl

-- error
-- homo' :: Int :~: Text
-- homo' = Refl

-- hetero :: Int :~~: Int
-- hetero = HRefl

hetero :: '[] :~~: '[]
hetero = HRefl

-- error
-- hetero' :: Int :~~: Text
-- hetero' = HRefl
