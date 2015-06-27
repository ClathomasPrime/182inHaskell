module Set
  (
  ) where

import Prelude hiding(elem)

--Here, we use a naive (i.e. inneficient but simple)
--implementation of sets as lists.

--In mathematics, sets are completely unordered.
--However, we will use a naive implementation,
--ordinary lists. We loose efficiency this way, but
--gain a little ease of so we can focus on mathematics.
data Set a = Nil | Element a (Set a)
--A set is either empty, or it contains an element
--followed by another set (this other set may be empty,
--or it may go on for a few more levels before you
--finally hit Nil). This is equivalent to a (singly)
--linked list, as well as the standard Haskell list:
--   > data [a] = [] | a:[a]
--   (pseudo Haskell -- lists are builtin so this 
--   syntax is invalid)
--Thus, we use ordinary lists for all our implementations.


--Almost every function in this file works on the Eq 
--typeclass only. If a type signature starts with 
--"Eq a =>" we know that the operators == and /= are
--defined for the elements of "a". "a" could be an
--element of Int, or Char, or even [Char], but it 
--could not be an element of (Int -> Char), for 
--instance, because it wouldn't be possible to
--tell if two functions are equal


--Let's start with the most basic set operation:
--testing if an item is in a set.
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem e (a:as) | e == a = True
              | otherwise = elem e as

--Because we use lists instead of data structures more
--geared towards sets, we may get repeats. nub attempts
--to solve this problem. num as returns all the unique
--elements of as. If several elements are all considered
--equal (i.e. a == b evaluates to True), nub only keeps 
--the first occurance.
nub :: Eq a => [a] -> [a]
nub [] = []
nub (a:as) = a : nub (filter (/= a) as)


--Union should now be easy!
union :: Eq a => [a] -> [a] -> [a]
union xs ys = nub $ xs ++ ys


intersection :: Eq a => [a] -> [a] -> [a]
intersection [] _ = []
intersection (x:xs) ys | x `elem` ys = x : intersection xs ys
                       | otherwise = intersection xs ys
