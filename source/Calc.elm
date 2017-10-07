port module Calc exposing (..)

import Platform exposing (..)
import Json.Decode exposing (..)
import Json.Encode exposing (..)

type Msg = Input (List Float)


add : Float -> Float -> Float
add a b =
    a + b

init : ({}, Cmd Msg)
init =
    ({}, Cmd.none)

port sendResult : Float -> Cmd msg
port receiveInput : (List Float -> msg) -> Sub msg

update : Msg -> {} -> ({}, Cmd Msg)
update msg model =
    case msg of
        Input [a,b] ->
            (model, (sendResult (add a b)))
        Input _ ->
            (model, Cmd.none)

subscriptions : {} -> Sub Msg
subscriptions _ =
    receiveInput Input


main : Program Never {} Msg
main =
    Platform.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


