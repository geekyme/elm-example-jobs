module Main exposing (..)

import Html exposing (Html, text, div, img, table, tbody)
import Html.Attributes exposing (..)
import TableHead
import TableRow
import Dict

---- MODEL ----


type alias Model =
  { jobs: Dict.Dict String TableRow.Model
  }

initialModel : Model
initialModel =
  { jobs = Dict.fromList
      [ ("1", TableRow.Model False "1" "test1" 123456789)
      , ("2", TableRow.Model False "2" "test2" 123456789)
      , ("3", TableRow.Model False "3" "test3" 123456789)
      , ("4", TableRow.Model False "4" "test4" 123456789)
      , ("5", TableRow.Model False "5" "test5" 123456789)
      ]
  }

init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

---- UPDATE ----


type Msg
  = TableHeadMsg TableHead.Msg
  | TableRowMsg TableRow.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    TableHeadMsg _ ->
      ( model, Cmd.none )

    TableRowMsg submsg ->
      let
        maybeJobId = TableRow.getJobId submsg
      in
        case maybeJobId of
          Nothing -> (model, Cmd.none)
          Just id ->
            let
              maybeJob = Dict.get id model.jobs
            in
              case maybeJob of
                Nothing -> (model, Cmd.none)
                Just job ->
                  let
                    (updatedJob, _) = TableRow.update submsg job
                  in
                    ({ model | jobs = Dict.insert id updatedJob model.jobs }, Cmd.none)

---- VIEW ----


view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ table [ class "table table-striped table-bordered" ]
        [ Html.map TableHeadMsg TableHead.view
        , tbody [] (renderRows model)
        ]
    ]

renderRows : Model -> List (Html Msg)
renderRows { jobs } =
  let
    f _ job jobsHtml = jobsHtml ++ ([Html.map TableRowMsg (TableRow.view job)])
  in
    Dict.foldl f [] jobs

---- PROGRAM ----


main : Program Never Model Msg
main =
  Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = always Sub.none
    }
