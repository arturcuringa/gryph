module Syntactic.Types where

data GType =    GInteger                            |
                GFloat                              |
                GString                             |
                GChar                               |
                GBool                               |
                GListEmpty                          |
                GDictEmpty                          |
                GList GType                         |
                GPair GType GType                   |
                GTriple GType GType GType           |
                GQuadruple GType GType GType GType  |
                GDict GType GType                   |
                GGraphEmpty                         |
                GEdgeEmpty                          |
                GGraphVertexEdge GType GType        |
                GUserType String                    |
                GAnonymousStruct
                deriving (Show, Eq, Ord)


