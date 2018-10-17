{-# LANGUAGE TupleSections #-}

module Main where

import           Control.Monad.State            ( )
import           Protolude

program1 :: State Text ()
program1 = state ((), )

program1' :: State a ()
program1' = state ((), )

program2 :: State Text (State Double ())
program2 = state (\text -> (state (\double -> ((), double)), text))
-- program2 = state (state ((),),)

-- XXX I"ve left it because it's wrong:
-- my sideeffects Int, Double are in the value!!!, of course I can't modify i
type Computation a = State Text (State Int (State Double a))

program3 :: Computation ()
program3 = state (state (state ((), ), ), )

-- return' :: a -> StateT b Identity a
-- return' a = state (a,)

program :: Computation ()
program = do
  put "test" -- why this works https://hub.darcs.net/ross/transformers/browse/Control/Monad/Trans/State/Lazy.hs#221 - because result can be passed to monad below
  -- same as `state $ \ _ -> ((), "test")`

  _ <- (return (put 1) :: StateT Text Identity (StateT Int Identity ())) -- of course value is ignored and I can't modify Int in this do block
  return . return . return $ ()


-- program :: Computation ()
-- program = do
--   put "test" -- eq to state $ \ _ -> ((), "test")
--   return . return . return $ ()


-- XXX: returns (1,2.0,"test")
-- interpret :: Computation a -> (Int, Double, Text)
-- interpret c =
--     let text = execState c ""
--     in (1, 2.0, text)

interpret :: Computation a -> (Int, Double, Text)
interpret c =
  let (c', text) = runState c "first"
  in  let (c'', int) = runState c' 999
      in  let (_ignored_a, double) = runState c'' 999.0 in (int, double, text)

main :: IO ()
main = print (interpret program)
