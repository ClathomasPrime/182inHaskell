{-# LANGUAGE TypeOperators
           , MultiParamTypeClasses
           , FlexibleInstances
           #-}
module TypeAlgebra
  (
  ) where

import Prelude hiding(Either(..))

infix 7 :*:
infix 6 :+:
infix 4 :==:

--Buckle up for some terminology folks, it's about to get technical.
--Haskell's algebraic data types for a commutative semiring
--where equality is defined as being isomorphic
--addition is given by Either
--multiplication is given by (,)
--the additive zero is Void 
--and the multiplicative unit is ().

--First let's encode Equality with a multiparam type class
class a :==: b where
  fw :: a -> b
  bw :: b -> a

--Now let's write (,) and Either infix:
data a :+: b = Left a | Right b 
  deriving Show
data a :*: b = Both a b 
  deriving Show

--And finally, let's define our constants
data Void  --completely uninhabited
data Unit = Unit

--That these form a commutative semiring is just the statement
--that :+: and :*: each for commutative monoids and satisfy the
--distributive law and zero law:

-- :+: forms a communtative monoid with Void
instance (a :+: b) :+: c  :==:  a :+: (b :+: c) where --associative
  fw (Left (Left a)) = Left a
  fw (Left (Right a)) = Right (Left a)
  fw (Right c) = Right (Right c)
  bw (Left a) = Left (Left a)
  bw (Right (Left b)) = Left (Right b)
  bw (Right (Right c)) = Right c

instance a :+: Void  :==:  a where
  fw (Left a) = a
  bw a = Left a

instance a :+: b  :==:  b :+: a where
  fw (Left a) = Right a
  fw (Right b) = Left b
  bw (Right a) = Left a
  bw (Left b) = Right b

-- :*: forms a communtative monoid with Unit
instance (a :*: b) :*: c  :==:  a :*: (b :*: c) where --associative
  fw (Both (Both x y) z) = Both x (Both y z)
  bw (Both a (Both b c)) = Both (Both a b) c

instance a :*: Unit  :==:  a where
  fw (Both a Unit) = a
  bw a = Both a Unit

instance a :*: b  :==:  b :*: a where
  fw (Both a b) = Both b a
  bw (Both b a) = Both a b

-- distributivity holds
instance a :*: (b :+: c)  :==:  a :*: b :+: a :*: c where
  fw (Both a (Left b)) = Left (Both a b)
  fw (Both a (Right c)) = Right (Both a c)
  bw (Left (Both a b)) = Both a (Left b)
  bw (Right (Both a c)) = Both a (Right c)

-- the zero law holds
instance a :*: Void  :==:  Void where
  fw (Both a v) = v
  bw v = Both undefined v

