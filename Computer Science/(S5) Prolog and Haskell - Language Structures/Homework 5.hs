-- Note: Your file must be free of typing errors. If your file can not
-- be loaded into ghci, then you will get 0 point. Please read the instructions
-- for each problem carefully. Failure to follow the instructions may result in
-- 0 point.


-- Problem 1 (2 points): Use pattern matching and recursion to define the
-- following 'myDrop' function. 
-- It drops the first n elements from a list.
-- We assume the input number is always greater or
-- equaled to 0. 

myDrop :: Int -> [a] -> [a]
myDrop _ [] = []
myDrop 0 as = as
myDrop n (a:as) = myDrop (n-1) as

-- For your convenient, your implementation
-- of myDrop should have the following
-- behavior from the interpreter.

-- > myDrop 3 [1,2,3,4,5]
-- [4,5]
-- > myDrop 3 []
-- []
-- > myDrop 3 [1,2]
-- []
-- > myDrop 0 [1,2]
-- [1,2]
-- > myDrop 4 [1,2]
-- []

-- Problem 2 (2 points): Use pattern matching and recursion to define the following 'myConcat' function. 
-- It concatenates a list of list into a list.
-- You may use the built-in append function (++) from Haskell. 
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (as:ass) = as ++ myConcat(ass)


-- Your function should at least satisfy the following
-- test case. 
-- > myConcat [[1,2], [3,4], [5,6]]
-- [1,2,3,4,5,6]

-- Problem 3 (2 points): Use pattern matching and recursion to define
-- the following 'duplicate' function. It produce a list with n identical elements.
-- We may assume the input number is always greater
-- or equaled to 0. 
duplicate :: Int -> a -> [a]
duplicate 0 _ = []
duplicate n a = [a] ++ duplicate (n-1) a

-- For example, 
-- > duplicate 3 'a'
-- "aaa"
-- > duplicate 3 '1'
-- "111"
-- > duplicate 3 1
-- [1,1,1]
-- > duplicate 0 1
-- []

-- Problem 4 (2 points):
-- Use pattern matching and recursion to define
-- the following 'myElem' function that decides if an input is an element of a list.

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e (a:as) = e == a || myElem e as 

-- For example, 
-- > myElem 1 [1,2,3,4]
-- True
-- > myElem 5 [1,2,3,4]
-- False    

-- Problem 5 (2 points): Use pattern matching and recursion to
-- define the following 'myMaximum' function that
-- return the maximum element in a list.

myMaximum :: (Ord a) => [a] -> Maybe a  
myMaximum [] = Nothing
myMaximum [a] = Just a
myMaximum (a:as) = 
    let x = (myMaximum as) 
    in if (Just a) >= x then (Just a) else x 
    

-- For example.
-- > myMaximum []
-- Nothing
-- > myMaximum [1,2,3,4]
-- Just 4

-- Problem 6 (1 point, but proceed with cautious).
-- Recall that
-- fibonacci sequence is defined as the following:
-- 0, 1, 1, 2, 3, 5 , 8, 13, ... . 
-- The n-th number in the sequence
-- is the sum of previous two numbers.

-- Define the following 'myFibs' that
-- produces the infinite list of fibonacci sequence.

-- Note: You solution must return (myFibs !! 100)
-- within 1 second. Your definition must use 
-- the concepts that we learned
-- from the class. You will not get point if
-- you uses concepts that are outside of the class.

myFibs :: [Integer]
myFibs = 0 : 1 : [x + y | (x, y) <- zip myFibs (tail myFibs)]


-- For example (Note that !! is an index function that obtains the nth element in a list):
-- > myFibs !! 3
-- 2
-- > myFibs !! 4
-- 3
-- > myFibs !! 5
-- 5
-- > myFibs !! 6
-- 8
-- > myFibs !! 100
-- > 354224848179261915075




