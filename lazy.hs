
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







aComplicatedComputation :: Bool
aComplicatedComputation = isPerfect $ 10^10
  --This computation takes a lot of time
  --(because it's poorly implemented lol)

isPerfect :: Integral a => a -> Bool
isPerfect a = a == sum (factors a)

factors :: Integral a => a -> [a]
factors a = filter dividesA [1..a-1]
  where dividesA x = a `mod` x == 0


