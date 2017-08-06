module TableRow exposing (..)
import Html exposing (Html, thead, tr, td, text, input, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Debug

type alias Model =
  { checkStatus: Bool
  , id: String
  , name: String
  , lastRun: Int
  }

type Msg
  = ToggleCheckbox String Bool
  | RunJob String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleCheckbox id status ->
      ({ model | checkStatus = status }, Cmd.none)

    RunJob id ->
      ({ model | lastRun = model.lastRun + 1000 }, Cmd.none )

getJobId : Msg -> Maybe String
getJobId msg =
  case msg of
    RunJob id -> Just id
    ToggleCheckbox id _ -> Just id

view : Model -> Html Msg
view { checkStatus, id, name, lastRun } =
  tr []
    [ td [] [ input [ type_ "checkbox", checked checkStatus, onCheck (\b -> ToggleCheckbox id b) ] [] ]
    , td [] [ text  id ]
    , td [] [ text name ]
    , td [] [ text "0%" ]
    , td [] [ text <| toString lastRun ]
    , td [] [ button [ onClick (RunJob id) ] [ text "Run" ] ]
    ]
