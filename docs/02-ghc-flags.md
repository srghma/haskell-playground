recommendations from https://github.com/commercialhaskell/rio#ghc-options

-Wall -- Turns on all warning options that indicate potentially suspicious code
-Wincomplete-record-updates -- like disallow non-total functions
-Wincomplete-uni-patterns -- warns about places where a pattern-match might fail at runtime, only to lambda-expressions
-fprint-potential-instances - for hie, show all potential instances, not only some
