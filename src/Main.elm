module Main exposing (..)

import Html exposing (Html, text, input, select, option, div)
import Html.Attributes exposing (value)
import Array exposing (Array)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import Util exposing (onChange)

type alias Flags =
    Int


type alias Model = 
   {  amount : Int
    , difficulty : Difficulty 
    , questions : Array Question
   }


init : Flags -> (Model, Cmd Msg)
init flags = 
    ( Model
        flags
        Data.Difficulty.default
        Array.empty
    , Cmd.none
    )
     
view : Model -> Html Msg
view { amount, questions } =
    div
        []
        [ input
            [ onChange UpdateAmount
            , value (toString amount)
            ]
            []
        , select [ onChange (ChangeDifficulty << Data.Difficulty.get)]
            (List.map (\key -> option [] [ text key ])
                Data.Difficulty.keys
            )
        , div
            []
            (questions
                |> Array.indexedMap (\i q -> View.Question.view (Answer i) q)
                |> Array.toList
            )
        ]

type Msg
    = Answer Int String 
    | UpdateAmount String
    | ChangeDifficulty Difficulty


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Answer i val ->
            ( model.questions
                |> Array.get i
                |> Maybe.map (\q -> { q | userAnswer = Just val })
                |> Maybe.map
                    (\q -> Array.set i q model.questions)
                |> Maybe.map
                    (\arr -> {model | questions = arr})
                |> Maybe.withDefault model
            , Cmd.none
            )

        UpdateAmount str ->
            case String.toInt str of
                Ok val ->
                    if val > 50 then
                        ( { model | amount = 50 }
                        , Cmd.none
                        )
                    else
                        ( { model | amount = val }
                        , Cmd.none
                        )

                Err err ->
                    ( model
                    , Cmd.none
                    )

        ChangeDifficulty lvl ->
            ( { model | difficulty = lvl }
            , Cmd.none
            )


main : Program Flags Model Msg
main = 
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }

