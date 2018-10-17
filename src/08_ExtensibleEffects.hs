{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE ExplicitForAll   #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs            #-}
{-# LANGUAGE MonoLocalBinds   #-}
{-# LANGUAGE RankNTypes       #-}
{-# LANGUAGE TypeOperators    #-}

module Main where

import           Control.Eff                    ( Eff
                                                , Member
                                                , run
                                                )
import           Control.Eff.Extend             ( handle_relay_s
                                                , send
                                                )
import           Control.Eff.State.Lazy         ( State
                                                , get
                                                , put
                                                , runState
                                                )
import           Control.Eff.Writer.Lazy        ( Writer
                                                , runMonoidWriter
                                                , tell
                                                )
import           Protolude               hiding ( State
                                                , get
                                                , put
                                                , runState
                                                )
import           System.Random                  ( mkStdGen
                                                , randomR
                                                )

-- https://github.com/stepchowfun/effects/blob/master/src/ExtensibleEffects.hs

-- A custom effect
data Random a where
  GetRandom :: Random Integer
  deriving (Typeable)

-- The operations
getRandom :: Member Random r => Eff r Integer
getRandom = send GetRandom

getAccumulator :: Member (State Integer) r => Eff r Integer
getAccumulator = get

setAccumulator :: Member (State Integer) r => Integer -> Eff r ()
setAccumulator = put

logOutput :: Member (Writer Text) r => Text -> Eff r ()
logOutput = tell

-- The program
program
  :: (Member Random r, Member (State Integer) r, Member (Writer Text) r)
  => Eff r ()
program = replicateM_ 10 $ do
  i <- getAccumulator
  logOutput (show i <> "\n")
  r <- getRandom
  setAccumulator (r + i)
  pure ()

-- A custom effect handler
runRandom :: Eff (Random ': r) a -> Eff r a
runRandom = handle_relay_s
  (mkStdGen 0)
  (const pure)
  (\s1 GetRandom k -> let (r, s2) = randomR (0, 9) s1 in k s2 r)

-- An interpreter
interpret
  :: (  forall r
      . (Member Random r, Member (State Integer) r, Member (Writer Text) r)
     => Eff r a
     )
  -> (a, Text)
interpret c =
  let ((x, o), _) =
        run . runState (0 :: Integer) . runMonoidWriter . runRandom $ c
  in  (x, o)

main :: IO ()
main = putStrLn . snd $ interpret program
