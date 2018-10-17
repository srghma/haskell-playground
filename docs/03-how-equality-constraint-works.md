## How instance resolution works

https://www.reddit.com/r/haskell/comments/61qm78/understanding_instance_resolution_and_constraints/dfiyimd

 1. Given a class declaration it can walk up to the superclasses of the class.
    e.g. Given Ord [[[[[a]]]]] I can tell you Eq [[[[[a]]]]] (class Eq a => Ord a)

 2. Given an instance declaration it pattern matches on the right hand side.

 ```hs
instance ... => B Wat
instance ... => B (C a)
instance ... => B (D a)
 ```

 and basically pattern matches like you would when writing a function using these as the patterns.
 When it finds a match, the instance tells it what obligations it has yet to prove.

## What equality constraint means:

1. https://chrisdone.com/posts/haskell-constraint-trick

2. https://www.yesodweb.com/blog/2012/07/classy-prelude

```
What we're defining instead is an instance for any unary function, and then with the b ~ c
equality constraint we're saying, "oh, and we only allow this to work if the input matches the output."
This means that if GHC is only able to identify the type of either the input or the output,
type inference still succeeds.
```

3. https://stackoverflow.com/a/11554793/3574379 (example with twice)
4. https://blog.infinitenegativeutility.com/2017/1/haskell-type-equality-constraints
