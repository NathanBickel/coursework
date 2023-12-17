-- Note: Your file must be free of typing errors. If your file can not
-- be loaded into ghci, then you will get 0 point. Please read the instructions
-- for each problem carefully. Failure to follow the instructions may result in
-- 0 point.

-- Problem 1 (2 points). Write down definitions that have the following types;
-- it does not matter what the definitions actually do as long as they are type correct.

curry' :: ((a, b) -> c) -> a -> b -> c
curry' f a b = f (a, b)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (a, b) = f a b 

-- Problem 2 (2 points): redefine the map function using foldr.
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\a as -> f a:as) []


-- Problem 3 (2 points): redefine the filter function using foldr.
filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldr (\a as -> if f a then a:as else as) []


-- Problem 4 (2 points): Deﬁne the following function altMap that
-- alternately applies its two argument functions to successive elements in a list,
-- in turn about order. For example:
-- > altMap (+10) (+100) [0,1,2,3,4]
-- [10,101,12,103,14]
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap f g [] = []
altMap f g (x:xs) = f x:altMap g f xs

-- Problem 5 (2 points): 
-- Use pattern matching and recursion to define a function 'halve'
-- that splits a list
-- into two halves whose lengths differ by at most one.
-- For example:
-- > halve [0,1,2,3,4]
-- ([0,2,4],[1,3])
-- > halve [0,1,2,3,4, 5]
-- ([0,2,4],[1,3,5])

halve :: [a] -> ([a], [a])
halve [] = ([], [])
halve (a:as) = (a:snd next, fst next)
    where next = halve(as)


-- Problem 6 (2 points)
-- Use pattern matching and recursion to deﬁne the function merge that
-- merges two sorted lists to give a single sorted list. For example:
-- > merge [2,5,6] [1,3,4]
-- [1,2,3,4,5,6]
-- > merge [1,5,5] [3,8]
-- [1,3,5,5,8]

merge :: Ord a => [a] -> [a] -> [a]
merge [] as = as
merge as [] = as
merge (x:xs) (y:ys) = if x <= y then x:merge xs (y:ys) else y:merge (x:xs) ys


-- Problem 7 (2 points)
-- Using the 'halve' and 'merge' functions, pattern matching and recursion to
-- define a function 'msort' that implements merge sort,
-- in which the empty list and singleton lists are already
-- sorted, and any other list is sorted by merging together the two lists that
-- result from sorting the two halves of the list separately.

msort :: Ord a => [a] -> [a]
msort [] = []
msort [a] = [a]
msort as = merge (msort (fst halved)) (msort (snd halved))
    where halved = halve as

-- > msort [5,9,8,6,5,4,3,2,1]
-- [1,2,3,4,5,5,6,8,9]  




