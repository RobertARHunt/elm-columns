module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Time


type alias Model =
    { contentView : ContentView
    }


initModel : () -> ( Model, Cmd Msg )
initModel _ =
    ( { contentView = TitleScreen }
    , Cmd.none
    )


type ContentView
    = TitleScreen
    | Playing


type Msg
    = Tick Time.Posix
    | StartGame


main : Program () Model Msg
main =
    Browser.element
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


view : Model -> Html Msg
view model =
    div []
        [ heading
        , content model.contentView
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartGame ->
            ( { model | contentView = Playing }, Cmd.none )

        Tick posix ->
            ( { model | contentView = TitleScreen }, Cmd.none )


heading : Html Msg
heading =
    div
        [ style "text-align" "center" ]
        [ h1 [] [ text "BOBBY'S COLUMNS" ] ]


content : ContentView -> Html Msg
content contentView =
    case contentView of
        TitleScreen ->
            div []
                [ text "Title Screen"
                , button [ onClick StartGame ] [ text "START GAME" ]
                ]

        Playing ->
            text "Playing"
