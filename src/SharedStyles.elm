module SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = ConfigForm
    | TriviaContainer


triviaNamespace =
    withNamespace "trivia"
