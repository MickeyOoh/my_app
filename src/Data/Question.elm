module Data.Question exposing (Question)

-- import Json.Decode exposing (Decoder, map3, field, string, list)


type alias Question = 
   {  userAnswer : Maybe String
    , question : String
    , correct : String
    , incorrect : List String
   } 

-- decode : Decoder Question
-- decode = 
    --map3
    --    (Question Nothing)
    --    (field "question" string)
