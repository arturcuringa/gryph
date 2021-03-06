{-# LANGUAGE FlexibleContexts #-}

module Syntactic.GTok where


import Syntactic.Lexer
import Syntactic.GphTokens
import Data.Char (isUpper)
import Syntactic.Values
import Syntactic.Syntax
import Data.Char

import Text.Parsec hiding (satisfy, string)

type Parser = Parsec [GphTokenPos] ()

satisfy :: (Stream [GphTokenPos] m GphTokenPos) => (GphTokenPos -> Bool) -> ParsecT [GphTokenPos] u m GphToken
satisfy f = tokenPrim show nextPos tokeq
    where 
        tokeq :: GphTokenPos -> Maybe GphToken
        tokeq t = if f t then Just (fst t) else Nothing

nextPos :: SourcePos -> GphTokenPos -> [GphTokenPos] -> SourcePos
nextPos pos _ ((_, AlexPn _ l c):_) = setSourceColumn (setSourceLine pos l) c
nextPos pos _ [] = pos

satisfy' :: (Stream [GphTokenPos] m GphTokenPos) => (GphTokenPos -> Maybe a) -> ParsecT [GphTokenPos] u m a
satisfy' = tokenPrim show nextPos

-- | Parses given `GphTokenPosen`.
tok :: (Stream [GphTokenPos] m GphTokenPos) => GphToken -> ParsecT [GphTokenPos] u m GphToken
tok t = satisfy (\(t', _) -> t' == t) <?> show t

tok' :: (Stream [GphTokenPos] m GphTokenPos) => GphToken -> ParsecT [GphTokenPos] u m ()
tok' p = tok p >> return ()

anyIdent :: Monad m => ParsecT [GphTokenPos] u m Identifier
anyIdent = satisfy' p <?> "ident"
    where 
        p (t,_) = case t of 
                    GTokIdentifier i -> Just (Ident i)
                    _ -> Nothing    

anyType :: Monad m => ParsecT [GphTokenPos] u m String
anyType = satisfy' p <?> "type"
    where 
        p (t,_) = case t of 
                    GTokType i -> Just i
                    GTokIdentifier is'@(i:is) -> 
                        if isUpper i then Just is'
                        else Nothing
                    _ -> Nothing    

numberLit :: Monad m => ParsecT [GphTokenPos] u m Literal
numberLit = satisfy' p <?> "number"
    where 
        p (t,_) = case t of
                    GTokIntLit i -> Just (Lit (Integer (read i)))
                    GTokFloatLit i -> Just (Lit (Float (read i)))
                    _ -> Nothing

stringLit :: Monad m => ParsecT [GphTokenPos] u m Literal
stringLit = satisfy' p <?> "string"
    where 
        p (t,_) = case t of
                    GTokStringLit "" -> Just (Lit (String ""))
                    GTokStringLit i  -> Just (Lit (String (tail (init (i)))))
                    _ -> Nothing

charLit :: Monad m => ParsecT [GphTokenPos] u m Literal
charLit = satisfy' p <?> "char"
    where 
        p (t,_) = case t of
                    GTokCharLit i -> case readLitChar (tail (init i)) of
                                        [(c,[])] -> Just (Lit (Char c))
                                        [(_,xs)] -> error "Not a valid char"
                    _ -> Nothing



