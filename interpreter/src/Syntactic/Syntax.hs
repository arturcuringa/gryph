module Syntactic.Syntax where

import Syntactic.Values

type Type = String

data Identifier = Ident String deriving(Show, Eq)

data Literal = Lit Value deriving(Show, Eq)

data SubprogCall = SubprogCall Identifier [ArithExpr] deriving(Show, Eq) -- change to anyExpr

data Stmt = ReadStmt Identifier | 
            PrintStmt Term | 
            DeclStmt [Identifier] Type [ArithExpr] | 
            AttrStmt [Identifier] [ArithExpr] |
            IfStmt RelExpr
            deriving (Show, Eq)
    

data ArithUnOp =    MinusUnOp | 
                    PlusUnOp 
                    deriving (Show, Eq)

data ArithBinOp =   MinusBinOp | 
                    PlusBinOp | 
                    TimesBinOp | 
                    DivBinOp | 
                    ModBinOp | 
                    ExpBinOp |
                    PlusPlusBinOp | 
                    TimesTimesBinOp 
                    deriving (Show, Eq)

data RelOp = 
            Greater |
            Less |
            GreaterEq|    
            LessEq |
            Equals |
            NotEquals 
            deriving (Show, Eq)

data BoolUnOp = Not deriving (Show, Eq)
data BoolBinOp = 
            And |
            Or |
            Xor 
            deriving (Show, Eq)

data BoolExpr = BoolBinExpr BoolBinOp BoolExpr BoolExpr |
                BoolUnExpr BoolUnOp BoolExpr 
                deriving (Show, Eq)

data AnyExpr = RelExpr RelExpr | ArithExpr ArithExpr deriving (Show, Eq)

data RelExpr = BinRelExpr RelOp AnyExpr AnyExpr deriving (Show, Eq)

data Term = LitTerm Literal | 
            IdTerm Identifier |
            SubcallTerm SubprogCall 
            deriving (Show, Eq)

data ArithExpr =    ArithUnExpr ArithUnOp ArithExpr | 
                    ArithBinExpr ArithBinOp ArithExpr ArithExpr | 
                    ArithTerm Term
                    deriving (Show, Eq)

data IdentList = IdentList [Identifier] deriving (Show, Eq)
