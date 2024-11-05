{-# OPTIONS_GHC -fplugin=LiquidHaskell #-}

module MyLib where

import Data.Set

{-@ type Pos = {v:Int | 0 < v} @-}

{-@ incr :: Pos -> Pos @-}
incr :: Int -> Int
incr x = x + 1
