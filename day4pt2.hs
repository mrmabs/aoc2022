import Data.List.Split
import Data.Char
import Data.List

main = interact day4pt1

day4pt1 :: String -> String
day4pt1 input =
    let allLines = lines input
        elves = map (splitOn ",") allLines
        numbs = map (map (splitOn "-")) elves
        zones = map (map (\x -> [(read (x!!0)::Int)..(read (x!!1)::Int)])) numbs
        score = map (\x -> if length (nub (sort (x!!0++x!!1))) /= length (x!!0++x!!1) then 1 else 0) zones
        result = show (sum score)
    in  result  
