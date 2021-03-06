module Syntactic.GphTokens where

{-| Tokens of the Gryph language -}
data GphToken =
    GTokIdentifier String           |
    GTokSemicolon                   |
    GTokBackslash                   |
    GTokSub                         |
    GTokIf                          |
    GTokElse                        |
    GTokFor                         |
    GTokFrom                        |
    GTokIn                          |
    GTokWhile                       |
    GTokReturn                      |
    GTokUse                         |
    GTokRead                        |
    GTokPrint                       |
    GTokPrintLn                     |
    GTokWhere                       |
    GTokAmpersand                   |
    GTokWhen                        |
    GTokOver                        |   
    GTokDFS                         |
    GTokBFS                         |
    GTokIntLit String               |
    GTokFloatLit String             |
    GTokCharLit String              |
    GTokStringLit String            |
    GTokBoolLit String              |
    GTokRightEdge                   |
    GTokLeftEdge                    |
    GTokDoubleEdge                  |
    GTokAnd                         |
    GTokOr                          |
    GTokXor                         |
    GTokNot                         |
    GTokTrue                        |
    GTokFalse                       |
    GTokRangeOp                     |
    GTokType String                 |
    GTokAt                          |
    GTokModulus                     |
    GTokAssignment                  |
    GTokPlus                        |
    GTokPlusPlus                    |
    GTokHat                         |
    GTokMinus                       |
    GTokTimes                       |  
    GTokTimesTimes                  |  
    GTokDivision                    |
    GTokComma                       |
    GTokColon                       |
    GTokEq                          |
    GTokNeq                         |
    GTokLess                        |
    GTokLessEq                      |
    GTokGreater                     |
    GTokGreaterEq                   |
    GTokLParen                      |
    GTokRParen                      |
    GTokLCurly                      |
    GTokRCurly                      |
    GTokLSquare                     |
    GTokRSquare                     |
    GTokQuestion                    |
    GTokExclam                      |
    GTokPipe                        |
    GTokBreak                       |
    GTokAdd                         |
    GTokDel                         |
    GTokPut                         |
    GTokDot                         |
    GTokUndefined String            |
    GTokError String
    deriving (Show, Eq) 
