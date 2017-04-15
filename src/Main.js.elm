module Main exposing (..)

import Html exposing (Html)


-- Abstraction

import Utils exposing (Component)


-- Components

import Component


counter : Component Model Component.Model Msg Component.Msg
counter =
    Utils.component
        { model = \subModel model -> { model | counter = subModel }
        , update = \subMsg model -> Component.update Even subMsg model.counter
        , init = Component.init Even
        , view = \model -> Component.view CounterMsg model.counter
        , subscriptions = \_ -> Sub.none
        }



-- Main


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions =
            subscriptions
                |> Utils.subscriptions counter
        }



-- Model


type alias Model =
    { even : Bool
    , counter : Component.Model
    }


updateCounter : Component.Model -> Model -> Model
updateCounter counterModel model =
    { model | counter = counterModel }


init : ( Model, Cmd Msg )
init =
    ( Model False, Cmd.none )
        |> Utils.init counter



-- Update


type Msg
    = CounterMsg Component.Msg
    | Even


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg subMsg ->
            ( { model | even = False }, Cmd.none )
                |> Utils.update counter subMsg

        Even ->
            ( { model | even = True }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    Html.div []
        [ Utils.view counter model
        , if model.even then
            Html.text "is even"
          else
            Html.text "is odd"
        ]
