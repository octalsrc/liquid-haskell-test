{-# OPTIONS_GHC -fplugin=LiquidHaskell #-}

module MyLib where

{-@ type TRUE = {v:Bool | v} @-}

{-@ example1 :: TRUE @-}
example1 :: Bool
example1 = True
