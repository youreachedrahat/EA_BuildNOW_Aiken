data Temp = Cold | Hot | Warm
  deriving (Eq, Show, Ord)

data Season = Summer | Rainy | Autumn | Winter
  deriving (Eq, Show)

data Month = January | February | March | April | May | June | July | August | September | October | November | December
  deriving (Eq, Show)


seasonToTemp :: Season -> Temp
seasonToTemp Summer = Hot
seasonToTemp Rainy = Cold
seasonToTemp Autumn = Warm
seasonToTemp Winter = Cold



monthToSeason :: Month -> Season
monthToSeason March     = Summer
monthToSeason April     = Summer
monthToSeason May       = Summer
monthToSeason June      = Summer
monthToSeason July      = Rainy
monthToSeason August    = Rainy 
monthToSeason September = Rainy
monthToSeason October   = Autumn
monthToSeason _         = Winter



monthTo_season :: Month -> String
monthTo_season month 
    | month `elem` [March, April, May] = show Summer
    | month `elem` [June, July, August] = show Rainy
    | month `elem` [September, October] = show Autumn
    | otherwise = show Winter


seqProduct :: Int -> Int -> Int
seqProduct m n 
    | m == n = n
    | m < n = m * seqProduct (m+1) n
    | m > n = 0






