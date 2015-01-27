module Function
  (
  ) where

import Prelude hiding
  ( (.)
  , ($)
  )

(.) :: (b -> c) -> (a -> b) -> (a -> c)
--Equivalently, (.) :: (b -> c) -> (a -> b) -> a -> c
(f . g) a = f (g a)

($) :: (a -> b) -> a -> b
f $ a = f a
infixr 0 $


