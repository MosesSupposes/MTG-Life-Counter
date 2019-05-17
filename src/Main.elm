module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, contenteditable, src)
import Html.Events exposing (onClick)



-- import Keyboard exposing (RawKey)
---- MODEL ----


type alias Player =
    { name : String, score : Int }


type alias Model =
    { p1 : Player
    , p2 : Player
    }


init : ( Model, Cmd Msg )
init =
    ( { p1 = Player "Moses" 20
      , p2 = Player "Casper" 20
      }
    , Cmd.none
    )



-- SUBSCRIPTIONS
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Keyboard.ups KeyUp
---- UPDATE ----


type Msg
    = Incrememnt Player
    | Decrement Player
    | Reset Player



-- | KeyUp RawKey


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Incrememnt player ->
            if player.name == model.p1.name then
                ( { model | p1 = { player | score = player.score + 1 } }, Cmd.none )

            else
                ( { model | p2 = { player | score = player.score + 1 } }, Cmd.none )

        Decrement player ->
            if player.name == model.p1.name then
                ( { model | p1 = { player | score = player.score - 1 } }, Cmd.none )

            else
                ( { model | p2 = { player | score = player.score - 1 } }, Cmd.none )

        Reset player ->
            if player.name == model.p1.name then
                ( { model | p1 = { player | score = 20 } }, Cmd.none )

            else
                ( { model | p2 = { player | score = 20 } }, Cmd.none )



-- KeyUp key ->
{--| TODO: Set "contentEditable" to False and update the player's name in the model
                 if the enter key was pressed
            --}
-- ( model, Cmd.none )
---- VIEW ----


view : Model -> Html Msg
view { p1, p2 } =
    div [ class "app" ]
        [ lifeCounter p1
        , lifeCounter p2
        ]


lifeCounter : Player -> Html Msg
lifeCounter player =
    div [ class "life-counter" ]
        [ div []
            [ span [ class "name", contenteditable True ] [ text player.name ]
            , p [ class "score" ] [ text (String.fromInt player.score) ]
            ]
        , div []
            [ button [ onClick (Incrememnt player) ] [ text "+" ]
            , button [ onClick (Decrement player) ] [ text "-" ]
            , button [ onClick (Reset player) ] [ text "reset" ]
            ]
        ]



-- custom event listener
-- onKeyDown : (Int -> msg) -> Attribute msg
-- onKeyDown tagger =
--     on "keyup" (Json.map tagger keyCode)
-- type alias KeyCode =
--     Int
-- keyCode : Json.Decoder KeyCode
-- keyCode =
--   Json.field "keyCode" Json.int
---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update

        -- , subscriptions = subscriptions
        , subscriptions = always Sub.none
        }
