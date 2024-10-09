import Data.Char (toUpper)


upcaseFirst :: String -> String
upcaseFirst (c:cs) = show $ toUpper c -- forgot ":cs" here

camelCase :: String -> String
camelCase xs = concatMap upcaseFirst (words xs)