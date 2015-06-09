module Logic
  ( Bool(..)
  ) where

import Prelude hiding(Bool(..), (&&), (||), and, or, not)

--In code, we constantly need to make decisions, and Boolean
--values often suffice to capture all of the information we
--need. In Haskell, it is entirely possible and actually
--relatively easy to completely define Booleans and many
--operations we would like to use, all from scratch.

--First, we need to declare the Bool data type.

data Bool = True | False

--Now, what are the first operations we do with True and False?
--`And' and `Or" of course! Let's start with a not-so-good
--definition for And to collect our thoughts:

(&&&) :: Bool -> Bool -> Bool
False &&& False = False --False &&& False =
False &&& True = False --False &&& True =
True &&& False = False --True &&& False =
True &&& True = True --True &&& True =

--It turns out you can define && and || in just two lines
--(after the type signature). Try it!

(&&) :: Bool -> Bool -> Bool
True && x = x
False && _ = False

(||) :: Bool -> Bool -> Bool
True || _ = True
False || x = x

--An interesting consequence of writing these functions this
--way has to do with lazy evaluation. Think about this: if &&
--sees that its first argument is true, it just has to pass on
--its second argument as the return value; it does not have to
--evaluate the second argument. Similarly, if && encounters
--False as its first argument, it will throw the second argument
--away entirely. This demonstrates how lazy evaluation can help
--Haskellers define custom control structures.
