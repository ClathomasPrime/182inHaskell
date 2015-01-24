module Logic
  ( Bool(..)
  ) where

import Prelude hiding
  ( Bool(..)
  , map
  , and
  , or
  , not
  )

data Bool = True | False
  deriving(Eq, Show, Read)

and :: Bool -> Bool -> Bool
True `and` True = True
_ `and` _ = False

or :: Bool -> Bool -> Bool
False `or` False = False
_ `or` _ = True

not :: Bool -> Bool
not True = False
not False = True


