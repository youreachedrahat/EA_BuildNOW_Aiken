import Data.Time.Format.ISO8601 (yearFormat)
-- Question 1
-- Write a function that checks if the monthly consumption of an electrical device is bigger, equal, or smaller than the maximum allowed and
-- returns a message accordingly. 
-- The function has to take the hourly consumption of an electrical device, the hours of daily use, and the maximum monthly consumption allowed.
-- (Monthly usage = consumption (kW) * hours of daily use (h) * 30 days).
electricalConsumption :: (Ord a, Num a) => p -> a -> a -> String
electricalConsumption h_con h_use max =
    let consumption = h_use * h_use * 30
    in if consumption > max
        then "more than allowed monthly consumption"
        else if consumption < max
            then "Below allowed consumption"
            else "Meets allowed consumption"



-- Question 2
-- Prelude:
-- We use the function `show :: a -> String` to transform any type into a String.
-- So `show 3` will produce `"3"` and `show (3 > 2)` will produce `"True"`.

-- In the previous function, return the excess/savings of consumption as part of the message.

electricalConsumptionUpdate :: (Ord a, Show a, Num a) => p -> a -> a -> [Char]
electricalConsumptionUpdate h_con h_use max =
    let consumption = h_use * h_use * 30
    in if consumption > max
        then "Exceeds allowed monthly consumption by " ++ show (consumption - max) ++ "kW"
        else if consumption < max
            then "Below allowed consumption by " ++ show (max - consumption) ++ "kW"
            else "Meets allowed consumption"

-- Question 3
-- Write a function that showcases the advantages of using let expressions to split a big expression into smaller ones.
-- Then, share it with other students in Canvas.


-- Question 4
-- Write a function that takes in two numbers and returns their quotient such that it is not greater than 1.
-- Return the number as a string, and in case the divisor is 0, return a message why the division is not
-- possible. To implement this function using both guards and if-then-else statements.  

quotientReturn :: (Ord a, Fractional a, Show a) => a -> a -> String
quotientReturn x y
    | x == 0 = "not divisible by 0"
    | x / y < 1 = show (x / y )
    | otherwise = "quotient more than one"


-- Question 5
-- Write a function that takes in two numbers and calculates the sum of square roots for the product and quotient
-- of those numbers. Write the function such that you use a where block inside a let expression and a
-- let expression inside a where block. 


fun :: Floating a => a -> a -> a
fun x y = let  
    result = productSqrt + quotientSqrt
  in result
  where
    productSqrt = let product = x * y in sqrt product
    quotientSqrt = let quotient = x / y in sqrt quotient




              
