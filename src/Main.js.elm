module Main exposing (..)

import Html exposing (Html)


-- Components

import Component


-- Main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- Model


type alias Model =
    { counter : Component.Model
    , even : Bool
    }


init : ( Model, Cmd Msg )
init =
    let
        ( cModel, cmd ) =
            Component.init Even
    in
        ( Model cModel False, cmd )



-- Update


type Msg
    = CounterMsg Component.Msg
    | Even


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg subMsg ->
            let
                ( cModel, cmd ) =
                    Component.update Even subMsg model.counter
            in
                { model
                    | counter = cModel
                    , even = False
                }
                    ! [ cmd ]

        Even ->
            ( { model | even = True }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    Html.div []
        [ Component.view CounterMsg model.counter
        , if model.even then
            Html.text "is even"
          else
            Html.text "is odd"
        ]
