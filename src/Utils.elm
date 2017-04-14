module Utils exposing (..)


initSubComponent : (subModel -> model) -> ( subModel, cmd ) -> ( model, cmd )
initSubComponent updateSubModel ( subModel, cmd ) =
    ( updateSubModel subModel, cmd )


updateSubComponent : (subModel -> model -> model) -> model -> ( subModel, cmd ) -> ( model, cmd )
updateSubComponent updateSubModel model ( subModel, cmd ) =
    ( updateSubModel subModel model, cmd )
