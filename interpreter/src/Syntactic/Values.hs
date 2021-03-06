module Syntactic.Values where

import qualified Data.Map.Strict as M
import qualified Execution.Graph as G
import qualified Data.Set as S
import Syntactic.Types

{- Values for all data types -}
data Value =    Integer Integer | 
                Float Double | 
                Char Char | 
                String String | 
                Bool Bool | 
                List [Value] | 
                EmptyList |
                Pair (Value, Value) | 
                Triple (Value, Value, Value) | 
                Quadruple (Value, Value, Value, Value) | 
                Map (M.Map Value  Value) |
                EmptyMap |
                Setter String (M.Map String (GType, Value)) |
                Graph (G.Graph Value Value)

instance Eq Value where
    (==) (Integer i) (Integer i2)       = i == i2 
    (==) (Float f) (Float f2)           = f == f2 
    (==) (Float f) (Integer i)          = f == fromInteger i  
    (==) (Integer i) (Float f)          = fromInteger i == f
    (==) (Char c) (Char c2)             = c == c2 
    (==) (String s) (String s2)         = s == s2 
    (==) (Bool b) (Bool b2)             = b == b2 
    (==) (List l1) (List l2)            = l1 == l2 
    (==) (EmptyList) (EmptyList)        = True 
    (==) (Pair p1) (Pair p2)            = p1 == p2 
    (==) (Triple t1) (Triple t2)        = t1 == t2 
    (==) (Quadruple q1) (Quadruple q2)  = q1 == q2 
    (==) (Map m1) (Map m2)              = m1 == m2
    (==) (EmptyMap) (EmptyMap)          = True 
    (==) (Graph (G.Graph v1 e1)) (Graph (G.Graph v2 e2)) = 
        ( (getSetOfValues (S.toList v1) S.empty) == (getSetOfValues (S.toList v2) S.empty) ) &&
        ( (createMapValueValue (createMapVertex (S.toList v1)) e1 M.empty) == (createMapValueValue (createMapVertex (S.toList v2)) e2 M.empty) )

    (==) (Setter t1 s1) (Setter t2 s2)  = t1 == t2 && s1 == s2

    (/=) (Integer i) (Integer i2)       = i /= i2 
    (/=) (Float f) (Float f2)           = f /= f2 
    (/=) (Float f) (Integer i)          = f /= fromInteger i  
    (/=) (Integer i) (Float f)          = fromInteger i /= f
    (/=) (Char c) (Char c2)             = c /= c2 
    (/=) (String s) (String s2)         = s /= s2 
    (/=) (Bool b) (Bool b2)             = b /= b2 
    (/=) (List l1) (List l2)            = l1 /= l2 
    (/=) (EmptyList) (EmptyList)        = False 
    (/=) (Pair p1) (Pair p2)            = p1 /= p2 
    (/=) (Triple t1) (Triple t2)        = t1 /= t2 
    (/=) (Quadruple q1) (Quadruple q2)  = q1 /= q2 
    (/=) (Map m1) (Map m2)              = m1 /= m2
    (/=) (EmptyMap) (EmptyMap)          = False 
    (/=) g1@(Graph _) g2@(Graph _)      = not (g1 == g2)
    (/=) (Setter t1 s1) (Setter t2 s2)  = t1 /= t2 && s1 /= s2

instance Ord Value where
    (<=) (Integer i) (Integer i2)       = i <= i2 
    (<=) (Float f) (Float f2)           = f <= f2 
    (<=) (Float f) (Integer i)          = f <= fromInteger i  
    (<=) (Integer i) (Float f)          = fromInteger i <= f
    (<=) (Char c) (Char c2)             = c <= c2 
    (<=) (String s) (String s2)         = s <= s2 
    (<=) (Bool b) (Bool b2)             = b <= b2 
    (<=) (List l1) (List l2)            = l1 <= l2 
    (<=) (EmptyList) (EmptyList)        = EmptyList <=  EmptyList 
    (<=) (Pair p1) (Pair p2)            = p1 <= p2 
    (<=) (Triple t1) (Triple t2)        = t1 <= t2 
    (<=) (Quadruple q1) (Quadruple q2)  = q1 <= q2 
    (<=) (Map m1) (Map m2)              = m1 <= m2
    (<=) (EmptyMap) (EmptyMap)          = EmptyMap <= EmptyMap
    (<=) (Graph g1) (Graph g2)          = g1 <= g2
    (<=) (Setter t1 s1) (Setter t2 s2)  = t1 <= t2 && s1 <= s2

    (<) (Integer i) (Integer i2)       = i < i2 
    (<) (Float f) (Float f2)           = f < f2 
    (<) (Float f) (Integer i)          = f < fromInteger i  
    (<) (Integer i) (Float f)          = fromInteger i < f
    (<) (Char c) (Char c2)             = c < c2 
    (<) (String s) (String s2)         = s < s2 
    (<) (Bool b) (Bool b2)             = b < b2 
    (<) (List l1) (List l2)            = l1 < l2 
    (<) (EmptyList) (EmptyList)        = EmptyList <  EmptyList 
    (<) (Pair p1) (Pair p2)            = p1 < p2 
    (<) (Triple t1) (Triple t2)        = t1 < t2 
    (<) (Quadruple q1) (Quadruple q2)  = q1 < q2 
    (<) (Map m1) (Map m2)              = m1 < m2
    (<) (EmptyMap) (EmptyMap)          = EmptyMap < EmptyMap
    (<) (Graph g1) (Graph g2)          = g1 < g2
    (<) (Setter t1 s1) (Setter t2 s2)  = t1 < t2 && s1 < s2

    (>) (Integer i) (Integer i2)       = i > i2 
    (>) (Float f) (Float f2)           = f > f2 
    (>) (Float f) (Integer i)          = f > fromInteger i  
    (>) (Integer i) (Float f)          = fromInteger i > f
    (>) (Char c) (Char c2)             = c > c2 
    (>) (String s) (String s2)         = s > s2 
    (>) (Bool b) (Bool b2)             = b > b2 
    (>) (List l1) (List l2)            = l1 > l2 
    (>) (EmptyList) (EmptyList)        = EmptyList >  EmptyList 
    (>) (Pair p1) (Pair p2)            = p1 > p2 
    (>) (Triple t1) (Triple t2)        = t1 > t2 
    (>) (Quadruple q1) (Quadruple q2)  = q1 > q2 
    (>) (Map m1) (Map m2)              = m1 > m2
    (>) (EmptyMap) (EmptyMap)          = EmptyMap > EmptyMap
    (>) (Graph g1) (Graph g2)          = g1 > g2
    (>) (Setter t1 s1) (Setter t2 s2)  = t1 > t2 && s1 > s2

instance Show Value where
   show (Integer x)   = show x
   show (Float x)     = show x
   show (Char x)      = show x
   show (String x)    = show x
   show (Bool x)      = show x
   show (List x)      = show x
   show (Pair x)      = show x
   show (Triple x)    = show x
   show (Quadruple x) = show x
   show (Map x)       = showDict (Map x)
   show (Graph x)     = showGraph (Graph x)
   show (Setter t x)  = t ++ " { " ++ showStruct (M.toList x) ++ " } "
   show EmptyList     = "[]"

showStruct :: (Show a, Show b, Show c) => [(a,(b,c))] -> String
showStruct [] = ""
showStruct [(k,(_,v))] = show k ++ " = " ++ show v
showStruct fs = concat (map (\(k,(_,v)) -> show k ++ " = " ++ show v ++ ",") (init fs))
                ++ (showStruct $ [last fs])

showDict :: Value -> String
showDict (Map x)     = if M.null x then "||" else "|" ++ f ( M.toList x) ++ "|"
                        where f []          = ""
                              f [(k,v)]     = (show k) ++ " ? " ++ (show v)
                              f ((k,v):xs)  = (show k) ++ " ? " ++ (show v) ++ ", " ++ (f xs) 


showGraph :: Value -> String
showGraph (Graph g@(G.Graph vs es)) = if S.null vs then "<>" else "<\n" ++ f (S.toList vs) g  ++ ">"
                                        where f [] g                    =  ""
                                              f (v@(G.Vertex _ x):xs) g = "    " ++  show x ++ " -> " ++ h (G.getEdges g v)  ++  "\n" ++ (f xs g)
                                              h []                      = ""
                                              h [(G.Edge _ v@(G.Vertex _ x) b)]         = show x ++ " (" ++ show b ++ ")"
                                              h ((G.Edge _ v@(G.Vertex _ x) b):xs)      = show x ++ " (" ++ show b ++ "), " ++ h xs   

getSetOfValues :: [G.Vertex Value] -> S.Set Value -> S.Set Value
getSetOfValues [] s                  = s
getSetOfValues ((G.Vertex _ x):xs) s = getSetOfValues xs (S.insert x s)

createMapVertex :: [G.Vertex Value] -> [(Value, Int)]
createMapVertex []                   = []
createMapVertex ((G.Vertex id x):xs) = (x,id) : (createMapVertex xs) 

createMapValueValue :: [(Value, Int)] -> M.Map Int [G.Edge Value Value] -> M.Map Value (S.Set (Value, Value)) -> M.Map Value (S.Set (Value, Value))
createMapValueValue [] _ r = r
createMapValueValue ((v,id):xs) m1 m2 = createMapValueValue xs m1 (createMapValueValue' v (m1 M.!? id) m2)
    where
        createMapValueValue' v xs m2 =
            case xs of
                Nothing  -> m2
                Just xs' -> M.insert v (createMapValueValue'' xs' S.empty) m2

        createMapValueValue'' [] s                              = s
        createMapValueValue'' ( G.Edge _ (G.Vertex _ v) w : xs) s = createMapValueValue'' xs (S.insert (v,w) s)
