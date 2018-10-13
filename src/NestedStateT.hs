module Main where

import           Protolude
import           Control.Monad.State ()

program2 :: StateT Text (State Double) ()
-- program2 = state (\text -> ((), text))
program2 = return () -- we always can make like this

type Computation = StateT Text (StateT Int (State Double))

program3 :: Computation ()
program3 = return ()

program :: Computation ()
program = do
  lift . lift $ put 2.0
  lift $ put 2
  put "test"
  return ()

interpret :: Computation a -> (Text, Int, Double)
interpret c =
    let (Identity (((_, text), int), double)) = runStateT (runStateT (runStateT c "first") 1) 1.0
    in (text, int, double)

main :: IO ()
main = print (interpret program)
