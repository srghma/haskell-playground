{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Mtl where

import           Protolude
import qualified Data.Text as Text
import           Control.Monad.Trans.Maybe

rightPassword :: Text
rightPassword = "secret"

isValid :: Text -> Bool
isValid = (==) rightPassword

getPassphrase :: MaybeT IO Text
getPassphrase = do s <- lift getLine
                   guard (isValid s) -- Alternative provides guard.
                   return s

askPassphrase :: MaybeT IO ()
askPassphrase = do lift $ putStrLn ( "Insert your new passphrase:" :: Text )
                   value <- getPassphrase
                   lift $ putStrLn ( "Storing in database..." :: Text)

