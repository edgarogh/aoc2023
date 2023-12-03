module Main (main) where

import Lib

defaultThreshold :: Lib.CubeSet
defaultThreshold = Lib.CubeSet 12 13 14

main :: IO ()
main = do
  putStrLn "Solution 1: "
  readFile "inputs/2.txt" >>= print . Lib.solution1 defaultThreshold
  putStrLn "Solution 2: "
  readFile "inputs/2.txt" >>= print . Lib.solution2
