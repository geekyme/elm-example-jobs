module TableHead exposing (..)

import Html exposing (Html, thead, tr, td, text)

type Msg
  = NoOp

view : Html Msg
view =
  thead []
    [ tr []
        [ td [] [ ]
        , td [] [ text "Job id" ]
        , td [] [ text "Name" ]
        , td [] [ text "Status" ]
        , td [] [ text "Last Run" ]
        , td [] [ ]
        ]
    ]
