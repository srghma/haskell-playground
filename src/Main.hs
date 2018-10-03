module Main where

import           ClassyPrelude
import Control.Monad.Writer

-- writer1 - log
-- writer2 - times

program1 :: WriterT Text Identity ()
program1 = WriterT (Identity ((), ""))

program12 :: WriterT Integer Identity ()
program12 = WriterT (Identity ((), 1))

program2 :: WriterT Text (WriterT Integer Identity) ()
program2 = WriterT (WriterT (Identity (((), ""), 1)))

program4 :: WriterT Integer (WriterT Text Identity) ()
program4 = WriterT (writer (((), 1), ""))

program :: WriterT Text (WriterT [Integer] Identity) ()
program = do
  lift $ tell [1]
  tell "test"
  return ()

interpret :: WriterT Text (WriterT [Integer] Identity) a -> ([Integer], Text)
interpret c =
    let ((_, text), list) = runWriter (runWriterT c)
    in (list, text)

main :: IO ()
main = print (interpret program)
