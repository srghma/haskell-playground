-- https://ocharles.org.uk/blog/guest-posts/2014-12-15-deriving.html
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Mtl where

import           Protolude
import qualified Data.Text as Text
import           Control.Monad.Trans.Maybe

data AppConfig = AppConfig { rightPassword :: Text }

newtype App m a = App { unApp :: ReaderT AppConfig m a }
  deriving (
    Functor,
    Applicative,
    Alternative,
    Monad,
    MonadPlus,
    MonadReader AppConfig,
    MonadState s,
    MonadError e
  )

isValid :: Monad m => Text -> App m Bool
isValid v =
  do
    p <- asks rightPassword
    return (v == p)

-- getPassphrase =
--   do log "Asking passphrase"
--      putText "Enter your passphrase:"
--      value <- getLine
--      log $ "Passphrase was: " <> value
--      guard $ isValid value
--      return value

-- askPassphrase =
--   do value <- msum $ repeat getPassphrase
--      putText "Storing in database..."

