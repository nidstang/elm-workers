port module Brain exposing (..)

import Platform exposing (..)

type Msg = Input Float Float


add : Float -> Float -> Float
add a b =
    a + b

init : (model, Cmd Msg)
init =
    (_, Cmd.none)

port sendResult : Float -> Cmd msg
port receiveInput : (Float -> Float -> msg) -> Sub msg

update : Msg -> model -> (model, Cmd Msg)
update msg _ ->
    case msg of
        Input a b ->
            (_, (sendResult (add a b)))

subscriptions : model -> Sub Msg
subscriptions _ =
    receiveInput Input


main : Program Never model Msg
main =
    Platform.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


