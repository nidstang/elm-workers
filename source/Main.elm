port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type alias Model =
    { a : Float
    , b : Float
    , result : Float
    }

type Msg = SetA String | SetB String | Calc | ReceiveResult Float

port sendData : List Float -> Cmd msg
port receiveResult : (Float -> msg) -> Sub msg

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

init : (Model, Cmd Msg)
init =
    (Model 0.0 0.0 0.0, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  receiveResult ReceiveResult

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetA number ->
            ({ model | a = (Result.withDefault 0 (String.toFloat number)) }, Cmd.none)
        SetB number ->
            ({ model | b = (Result.withDefault 0 (String.toFloat number)) }, Cmd.none)
        Calc ->
            (model, sendData [model.a, model.b])
        ReceiveResult result ->
            ({ model | result = result }, Cmd.none)

view : Model -> Html Msg
view model =
    div [] 
        [ input [ onInput SetA, placeholder "Number one", Html.Attributes.type_ "number" ] [ ]
        , input [ onInput SetB, placeholder "Number two", Html.Attributes.type_ "number" ] [ ]
        , input [ value (toString model.result) ] [ ] 
        , button [ onClick Calc ] [ text "Calc" ] ]