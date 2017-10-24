module Playground where

import Control.Monad.Trans.List
import Protolude
import System.Directory
import System.FilePath

addIndex :: [b] -> [(Integer, b)]
addIndex = zip [0 ..]

times :: Integer
times = 4

select :: (Foldable f, Alternative m) => f a -> m a
select = foldr cons empty
  where
    cons x xs = pure x <|> xs

main :: IO ()
main = do
  _ <-
    runListT $ do
      cwd <- lift getCurrentDirectory
      files <- lift $ listDirectory cwd
      path <- select files
      i <- select [0 .. times]
      let base = takeBaseName path
      let newbase = base ++ show i
      let newpath = replaceBaseName path newbase
      traceShowM (path, newpath)
      lift $ copyFile path newpath
  return ()
--
-- main :: IO ()
-- main = do
--   cwd <- getCurrentDirectory
--   files <- listDirectory cwd
--   let whatWhereList :: [(FilePath, FilePath)] = do
--         path <- files
--         i <- [0 .. times]
--         let base = takeBaseName path
--         let newbase = base ++ show i
--         let newpath = replaceBaseName path newbase
--         return (path, newpath)
--   mapM_ (uncurry copyFile) whatWhereList
