module Lib
  ( CubeSet (..),
    solution1,
    solution2,
    parseFile,
  )
where

import Data.Char (digitToInt)
import Data.Function ((&))
import Text.Parsec (endBy, endOfLine, parse, parsecMap, (<|>))
import Text.Parsec.Char (digit, string)
import Text.Parsec.Combinator (many1, sepBy)
import Text.Parsec.String (Parser)

data CubeSet = CubeSet
  { red :: Integer,
    green :: Integer,
    blue :: Integer
  }

data Game = Game
  { gId :: Integer,
    gSup :: CubeSet
  }

emptyCubeSet :: CubeSet
emptyCubeSet = CubeSet 0 0 0

isDrawPossible :: CubeSet -> CubeSet -> Bool
isDrawPossible threshold draw = (red draw <= red threshold) && (green draw <= green threshold) && (blue draw <= blue threshold)

mergeCubeSet :: CubeSet -> CubeSet -> CubeSet
mergeCubeSet (CubeSet a_r a_g a_b) (CubeSet b_r b_g b_b) = CubeSet (max a_r b_r) (max a_g b_g) (max a_b b_b)

parseDec :: Parser Integer
parseDec = do
  digits <- many1 baseDigit
  let n = foldl (\x d -> base * x + toInteger (digitToInt d)) 0 digits
  seq n (return n)
  where
    base = 10
    baseDigit = digit

parseCubes :: Parser CubeSet
parseCubes = do
  count <- parseDec
  _ <- string " "
  (CubeSet count 0 0 <$ string "red")
    <|> (CubeSet 0 count 0 <$ string "green")
    <|> (CubeSet 0 0 count <$ string "blue")

parseLine :: Parser Game
parseLine = do
  _ <- string "Game "
  gameId <- parseDec
  _ <- string ": "
  parsecMap (foldl mergeCubeSet emptyCubeSet) (parseCubes `sepBy` (string ", " <|> string "; ")) & parsecMap (Game gameId)

parseFile :: Parser [Game]
parseFile = parseLine `endBy` endOfLine

solution1 :: CubeSet -> String -> Integer
solution1 threshold input = case parse parseFile "" input of
  Left err -> error "err"
  Right list -> list & filter (isDrawPossible threshold . gSup) & map gId & sum

powerCubeSet :: CubeSet -> Integer
powerCubeSet (CubeSet r g b) = r * g * b

solution2 :: String -> Integer
solution2 input = case parse parseFile "" input of
  Left err -> error "err"
  Right list -> list & map (powerCubeSet . gSup) & sum
