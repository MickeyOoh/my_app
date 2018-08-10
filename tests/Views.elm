module Views exposing (..)

import Test exposing (Test, test, fuzz)
import Fuzz exposing (string)
import Test.Html.Query
import Test.Html.Selector exposing (text, tag)
import Html exposing (div)
import View.Button


suite : Test
suite =
    --test "Button renders the label"
    fuzz string
        "Button renders the label"
        (\label ->
            div [] [ View.Button.btn (\_ -> never) label ]
                |> Test.Html.Query.fromHtml
                |> Test.Html.Query.find [ tag "button" ]
                |> Test.Html.Query.has [ text label ]
        )
