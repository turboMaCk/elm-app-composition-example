module Main exposing (..)

import Html exposing (Html)


-- Abstraction

import Utils


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


updateCounter : Component.Model -> Model -> Model
updateCounter counterModel model =
    { model | counter = counterModel }


init : ( Model, Cmd Msg )
init =
    Component.init Even
        |> Utils.initSubComponent
            (\subModel -> { counter = subModel, even = False })



-- Update


type Msg
    = CounterMsg Component.Msg
    | Even


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg subMsg ->
            Component.update Even subMsg model.counter
                |> Utils.updateSubComponent
                    updateCounter
                    { model | even = False }

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
