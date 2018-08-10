module Decoders exposing (..)

import Test exposing (..)
import Expect
import Json.Decode
import Data.Question exposing (Question)
import Request.TriviaQuestions exposing (TriviaResults)


-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


all : Test
all =
    test "Request.TriviaQuestions.decoder can decode JSON"
        (\_ ->
            let
                input =
                    """
                    {
                        "response_code":0,
                        "results":[
                            {
                                "category":"Animals",
                                "type":"multiple",
                                "difficulty":"medium",
                                "question":"What is the scientific name for the &quot;Polar Bear&quot;?",
                                "correct_answer":"Ursus Maritimus",
                                "incorrect_answers":[
                                    "Polar Bear",
                                    "Ursus Spelaeus",
                                    "Ursus Arctos"
                                ]
                            }
                        ]

                    }
                    """

                decodedOutput =
                    Json.Decode.decodeString Request.TriviaQuestions.decoder input
            in
                Expect.equal decodedOutput
                    (Ok
                        (TriviaResults
                            0
                            [ Question
                                Nothing
                                "What is the scientific name for the &quot;Polar Bear&quot;?"
                                "Ursus Maritimus"
                                [ "Polar Bear"
                                , "Ursus Spelaeus"
                                , "Ursus Arctos"
                                ]
                            ]
                        )
                    )
        )
