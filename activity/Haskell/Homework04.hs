-- Question 1
-- Lets say you have the nested values defined bellow. How would you get the value of
-- 4 by using only pattern matching in a function?

nested :: [([Int], [Int])]
nested = [([1,2],[3,4]), ([5,6],[7,8])]

get4 :: [(a1, [a2])] -> a2
get4 [(_,[_,x]),_] = x

-- Question 2
-- Write a function that takes a list of elements of any type and, if the list has 3 or more elements, it
-- removes them. Else, it does nothing. Do it two times, one with multiple function definitions and one with
-- case expressions.

max3def [x]=[x]
max3def [x,y]=[x,y]
max3def [x,y,_]=[]

max3case xs = case xs of 
    [x] -> [x]
    [x,y] -> [x,y]
    [x,y,_] -> []


-- Question 3
-- Create a function that takes a 3-element tuple (all of type Integer) and adds them together
tupleAdd (x,y,z) = x + y + z


-- Question 4
-- Implement a function that returns True if a list is empty and False otherwise.

isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _  = False


-- Question 5
-- Write the implementation of the tail function using pattern matching. But, instead of failing if
-- the list is empty, return an empty list.
safeTail :: [a] -> [a]
safeTail []     = []
safeTail (_:xs) = xs

-- Question 6
-- write a case expression wrapped in a function that takes an Int and adds one if it's even. Otherwise does nothing. 
-- (Use the `even` function to check if the number is even.)

fun x = case even x of 
    True -> x + 1
    False -> x