module PrettyStub where

import SimpleJSON
import Prelude hiding ((<>))

punctuate :: Doc -> [Doc] -> [Doc]
punctuate p []     = []
punctuate p [d]    = [d]
punctuate p (d:ds) = (d <> p) : punctuate p ds



data Doc = Empty
         | Char Char
         | Text String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
           deriving (Show,Eq)


empty :: Doc
empty = Empty

char :: Char -> Doc
char = Char

line :: Doc
line = Line

text :: String -> Doc
text "" = Empty
text s  = Text s

double :: Double -> Doc
double d = text (show d)

string :: String -> Doc
string str = undefined


(<>) :: Doc -> Doc -> Doc
Empty <> y = y
x <> Empty = x
x <> y = x `Concat` y


hcat :: [Doc] -> Doc
hcat = fold (<>)

fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty

fsep :: [Doc] -> Doc
fsep = fold (</>)

(</>) :: Doc -> Doc -> Doc
x </> y = x <> softline <> y

softline :: Doc
softline = group line

group :: Doc -> Doc
group x = flatten x `Union` x

flatten :: Doc -> Doc
flatten (x `Concat` y) = flatten x `Concat` flatten y
flatten Line           = Char ' '
flatten (x `Union` _)  = flatten x
flatten other          = other

compact :: Doc -> String
compact x = transform [x]
    where transform [] = ""
          transform (d:ds) =
              case d of
                Empty        -> transform ds
                Char c       -> c : transform ds
                Text s       -> s ++ transform ds
                Line         -> '\n' : transform ds
                a `Concat` b -> transform (a:b:ds)
                _ `Union` b  -> transform (b:ds)

compact' x = transform [x]
    where transform [] = ""
          transform (d:ds)
            | d == Empty = transform ds
            | d == Char c = c : transform ds
            | d == Text s = s ++ transform ds
            | d == Line = '\n' : transform ds
            | d == a `Concat` b = transform (a:b:ds)
            | d == _ `Union` b = transform (b:ds)

compact'' x = transform [x]
  where
    transform [] = ""
    transform (Empty:ds) = transform ds
    transform (Char c:ds) = c : transform ds
    transform (Text s:ds) = s ++ transform ds
    transform (Line:ds) = '\n' : transform ds
    transform (a `Concat` b:ds) = transform (a:b:ds)
    transform (_ `Union` b:ds) = transform (b:ds)            

pretty width x = best 0 [x]
    where best col (d:ds) =
              case d of
                Empty        -> best col ds
                Char c       -> c :  best (col + 1) ds
                Text s       -> s ++ best (col + length s) ds
                Line         -> '\n' : best 0 ds
                a `Concat` b -> best col (a:b:ds)
                a `Union` b  -> nicest col (best col (a:ds))
                                           (best col (b:ds))
          best _ _ = ""

          nicest col a b | (width - least) `fits` a = a
                         | otherwise                = b
                         where least = min width col


pretty' width x = best 0 [x]
    where best col (Empty:ds) = best col ds
          best col (Char c:ds) = c :  best (col + 1) ds
          best col (Text s:ds) = s ++ best (col + length s) ds
          best col (Line:ds) ='\n' : best 0 ds
          best col (a `Concat` b:ds) = best col (a:b:ds)
          best col (a `Union` b:ds) = nicest col (best col (a:ds)) (best col (b:ds))
          best _ _ = ""

          nicest col a b | (width - least) `fits` a = a
                         | otherwise                = b
                         where least = min width col


fits :: Int -> String -> Bool
w `fits` _ | w < 0 = False
w `fits` ""        = True
w `fits` ('\n':_)  = True
w `fits` (c:cs)    = (w - 1) `fits` cs                         