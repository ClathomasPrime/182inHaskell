
--Consider the difference between the following two
--definitions of &&

and1 :: Bool -> Bool -> Bool
False `and1` False = False
False `and1` True = False
True `and1` False = False
True `and1` True = True

and2 :: Bool -> Bool -> Bool
False `and2` _ = False
True `and2` x = x

--Because we specified `and1' very explicitly, it has to examine
--both of its arguments before it returns any result.

--In contrast, think about this: if `and2'
--sees that its first argument is true, it just has to pass on
--its second argument as the return value; it does not have to
--look at the second argument. Similarly, if `and2' encounters
--False as its first argument, it will throw the second argument
--away entirely.

--It is a common optimization in imparative language to
--"short circuit" out of boolean expressions. For example,
--if the first argument to || is True, the second argument
--(and all its possible side effect) are thrown away.
--This is exactly what happens in `and2'.

--To see this in action, run the following two lines:
strict =  False `and1` aComplicatedComputation
nonStrict = False `and2` aComplicatedComputation
--and see what happens in each case.

--We say that and1 is "strict" in its arguments, formally meaning that
--if you pass in a non-terminating computation, your
--computation must not terminate. The theory of computation
--tells us that there is no way to know if an arbitrary
--program will terminate short of running it; thus strict
--functions must run the code to generate their arguments.

--This demonstrates how lazy evaluation can help
--Haskellers define custom control structures.
--Evaluation resembles imperative controll flow in that
--only the relevant branches are evaluated.

myIf :: Bool -> a -> a -> a
myIf True t _ = t
myIf False _ f = f




--Here's a question to ask yourself: what is the simplest
--nonterminating computation you can think of?

--Here's my answer:
bottom = let x = x in x
--If you try to evaluate bottom, the program says 
--"Okay, I can do that, I just look after the 'in' and I 
--then see that the answer is just x. Well, x is set in 
--the let binding right over there, and it turns out x is
--just x. So now I have to evaluate x. But I see x is x."
--And so on ad infinitum.

--Here's another question: what should the type of bottom be?
--The answer, surprisingly, is
bottom :: a
--You see, there will never be any clues to what the type of 
--bottom should be, because there will never be any data.
--We can't say bottom should or shouldn't be an int, because
--no bytes will every be produced to say whether that looks
--right or wrong. There's just bottom = x, where x can also be
--any type a, because x is just x, which is just x...

--The deap truth is that any computation can fail, and thus
--bottom "lurks" as an extra member of every type in Haskell.
--The elements of Bool are really {True, False, bottom}.
--The elements of () are really {(), bottom}.
--Even Void turns out to have an inhabitant, namely bottom.
--(You can check out Void over in typeAlgebra.hs is you like).


--The name bottom comes from type theory and mathematics.
--Top, symbolized T, is just (), and represents the value
--of True within the world of types. Bottom, symbolized _|_,
--is just Void, and represents False.

--It isn't very helpful if your program loops forever and
--doesn't provide an error message. Thus, Haskell provides
--functions that are semantically like bottom, but stop
--execution so you can see what went wrong. These functions are:

--error :: String -> a
--undefined :: a





aComplicatedComputation :: Bool
aComplicatedComputation = isPerfect $ 10^10
  --This computation takes a lot of time
  --(because it's poorly implemented lol)

isPerfect :: Integral a => a -> Bool
isPerfect a = a == sum (factors a)

factors :: Integral a => a -> [a]
factors a = filter dividesA [1..a-1]
  where dividesA x = a `mod` x == 0


