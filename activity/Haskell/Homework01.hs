
-- Question 1
-- Write a multiline comment below.
{-
This is a 
multiline comment
-}

-- Question 2
-- Define a function that takes a value and multiplies it by 3.
mul3 :: Num a => a -> a
mul3 x = x * 3

-- Question 3
-- Define a function that calculates the area of a circle.
areaOfCircle :: Fractional a => a -> a
areaOfCircle r = 3.14 * r ^2

-- Question 4
-- Define a function that calculates the volume of a cylinder by composing the previous function together with the height of the cylinder. 
volumeOfCylinder :: Fractional a => a -> a -> a
volumeOfCylinder r h = areaOfCircle r * h

-- Question 5
-- Define a function that takes the height and radius of a cylinder and checks if the volume is greater than or equal to 42.
cylinderVolumeCheck :: (Ord a, Fractional a) => a -> a -> Bool
cylinderVolumeCheck r h = volumeOfCylinder r h >= 42