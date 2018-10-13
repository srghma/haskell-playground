module Main

test : List (Maybe Integer)
test = [Just 1]

-- using (.) from prelude
test1 : (List . Maybe) Integer
test1 = [Just 1]

-- using (.) and ($) from prelude
test2 : List . Maybe $ Integer
test2 = [Just 1]

main : IO ()
main = do
  print test
  print test1
  print test2
