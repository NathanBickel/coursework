

-- Problem 1. Supply a type annotation for each of the following definitions. 
-- For example, p0 with type annotation looks like the following. 
p0 :: Char
p0 = 'a'

-- (1) 1 point.  

p1 :: [Char]
p1 = ['a', 'b', 'c']

-- (2) 1 point.  

p2 :: [(Bool, Char)]
p2 = [(False, '0'), (True, '1')]

-- (3) 1 point.

p3 :: ([Bool], [Char])
p3 = ([False, True], ['0', '1'])

-- (4) 1 point.

p4 :: [[a] -> [a]]
p4 = [tail, init, reverse]

-- Problem 2. Recall the following
-- functions on list.
-- length :: [a] -> Int
-- head :: [a] -> a
-- tail :: [a] -> [a]
-- reverse :: [a] -> [a]
-- init :: [a] -> [a]
-- last :: [a] -> a

-- (1) 2 points. Define 'last' using only {'head', 'tail', 'reverse'}.
-- Note that we will call it last' to avoid conflict with the built-in 'last'.
-- You do not need to use all of the {'head', 'tail', 'reverse'}. 

last' :: [a] -> a
last' xs = head (reverse xs)

-- (2) 2 points. Define 'init' using only 'head', 'tail' and 'reverse'.
-- Note that we will call it init' to avoid conflict with the built-in 'init'. 
-- You do not need to use all of the {'head', 'tail', 'reverse'}. 
init' :: [a] -> [a]
init' xs = reverse (tail (reverse xs))


-- Problem 3. Write down definitions that have the following types;
-- it does not matter what the definitions actually do as long as they are type correct. Note that
-- you cannot use 'undefined' in your definitions. 

-- (1) 1 point.
d1 :: a -> (a, a)
d1 a = (a, a) 

-- (2) 1 point.
d2 :: a -> a 
d2 a = a

-- (3) 1 point.
d3 :: a -> b -> a 
d3 a b = a

-- (4) 1 point.
d4 :: (a -> b) -> a -> b
d4 f a = f a

-- (5) 1 point.
d5 ::  (a -> (b -> c)) -> ((a -> b) -> (a -> c))
d5 f g a = f a (g a)
