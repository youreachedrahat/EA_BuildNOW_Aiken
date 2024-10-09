data BookInfo = Book Int String [String]
                deriving (Show)

data MagazineInfo = Magazine Int String [String]
                deriving (Show)                

myInfo = Book 9780135072455 "Algebra of Programming"
                ["Richard Bird", "Oege de Moor"]

type CustomerID = Int
type ReviewBody = String                

data BookReview = BookReview BookInfo CustomerID String

type BookRecord = (BookInfo, BookReview)



-- Algebraic data types
-- Bool is the simplest common example 
data Bool = False | True


type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerID
                   deriving (Show)

bookID      (Book id title authors) = id
bookTitle   (Book id title authors) = title
bookAuthors (Book id title authors) = authors

data Customer = Customer {
      customerID      :: CustomerID
    , customerName    :: String
    , customerAddress :: Address
    } deriving (Show)

customer1 :: Customer
customer1 = Customer 271828 "J.R. Hacker"
            ["255 Syntax Ct",
             "Milpitas, CA 95134",
             "USA"]

customer2 = Customer {
              customerID = 271828
            , customerAddress = ["1048576 Disk Drive",
                                 "Milpitas, CA 95134",
                                 "USA"]
            , customerName = "Jane Q. Citizen"
            }

data List a = Cons a (List a)
            | Nil
              deriving (Show)


fromList (x:xs) = Cons x (fromList xs)
fromList []     = Nil


fromList' (Cons x xs) = x : fromList' xs
fromList' Nil = []

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

simpleTree = Node "parent" (Node "left child" Empty Empty)
                           (Node "  `        child" Empty Empty)


data Tree'' a = Node'' a (Maybe (Tree'' a)) (Maybe (Tree'' a))
                deriving (Show)
        

mySecond xs = if null (tail xs)
              then error "list too short"
              else head (tail xs)


safeSecond [] = Nothing
safeSecond xs = if null (tail xs)
                then Nothing
                else Just (head (tail xs))

tidySecond (_:x:_) = Just x
tidySecond _       = Nothing

lend amount balance = let reserve    = 100
                          newBalance = balance - amount
                      in if balance < reserve
                         then Nothing
                         else Just newBalance

foo = let a = 1
      in let b = 2
         in a + b

bar :: (String, Integer)
bar = let x = 1
      in (let x = "foo" in x, x)


quux a = let a = "foo"
         in a ++ "eek!"

lend' :: (Ord a, Num a) => a -> a -> Maybe a
lend' amount balance = if balance < reserve then Nothing
                        else Just newBalance
                        where reserve = 100
                              newBalance= balance - amount
foo' = a + c 
        where a = 1
              c=b
                    where b = 2   
              
-- bar' = (x 
--         where x = "foo",x)

quux' a = a ++ "eek!"
        where a = "foo"


pluralise :: String -> [Int] -> [String]
pluralise word counts = map plural counts
    where plural 0 = "no " ++ word ++ "s"
          plural 1 = "one " ++ word
          plural n = show n ++ " " ++ word ++ "s"




fromMaybe defval wrapped =
    case wrapped of
      Nothing     -> defval
      Just value  -> value

fromMaybe' _ (Just a) = a
fromMaybe' defval _   = defval



data Fruit = Apple | Orange
betterFruit f = case f of
                  "apple"  -> Apple
                  "orange" -> Orange
betterFruit' "apple"  = Apple
betterFruit' "orange" = Orange

myDrop n xs = if n <= 0 || null xs
              then xs
              else myDrop (n - 1) (tail xs)

myDrop' n xs
    | n<=0 || null xs = xs
    | otherwise = myDrop' (n-1) (tail xs)



length' (x:xs) = 1 + length' xs
length' []  = 0

sum' (x:xs) = x + sum' xs
sum' [] = 0
mean' xs = sum' xs / length' xs





-- Turn a list into a palindrome, i.e. it should read the same both backwards and forwards. For example, given the list [1,2,3], your function should return [1,2,3,3,2,1]. 88 comments
-- Write a function that determines whether its input list is a palindrome. 95 comments
-- Create a function that sorts a list of lists based on the length of each sublist. (You may want to look at the sortBy function from the Data.List module.) 54 comments
-- Define a function that joins a list of lists together using a separator value. 
-- join' ',' ["foo","bar","baz","quux"]
-- "foo,bar,baz,quux"




