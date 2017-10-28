module Playground where

import Control.Monad.Trans.Cont
import Protolude

-- Without callCC
square :: Int -> Cont r Int
square n = return (n ^ 2)

-- With callCC
squareCCC :: Int -> Cont r Int
squareCCC n = callCC $ \k -> k (n ^ 2)

quux :: Cont r Int
quux =
  callCC $ \k -> do
    let n = 5
    when True $ k n
    return 25

-- -- b can be any because it is ignored yo
-- -- callCC :: ((a -> Cont r b) -> Cont r a) -> Cont r a
-- callCC' f = cont $ \print -> runCont (f k) print
--   where
--     k a = cont $ \_ -> print a
divExcpt ::
     IsString str
  => Int
  -> Int
  -> (str -> ContT r Either Int)
  -> ContT r Either Int
divExcpt x y handler =
  callCC $ \ok -> do
    err <-
      callCC $ \notOk -> do
        when (y == 0) $ notOk "Denominator 0"
        ok $ x `div` y
    handler err

main :: IO ()
main = (`runCont` print) $ divExcpt 1 0 (lift . print)
