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
infixr 9 .

($) :: (a -> b) -> a -> b
f $ a = f a
infixr 0 $

crossF :: (z -> a) -> (z -> b) -> z -> (a,b)
crossF f g z = (f z, g z)

plusF :: (a -> z) -> (b -> z) -> Either a b -> z
plusF f g e = case e of
                   Left a -> f a
                   Right b -> g b
