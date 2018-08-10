module TriviaCss exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import SharedStyles exposing (triviaNamespace, CssClasses(..))


css =
    (stylesheet << namespace triviaNamespace.name)
        []
