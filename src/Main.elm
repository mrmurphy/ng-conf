module Main (..) where

import Signal exposing (Address)
import StartApp.Simple exposing (start)
import Html exposing (..)
import EasyEvents exposing (onInput)
import Markdown

type alias Model =
  { mdown : String
  , css : String
  }

type Action
  = NoOp
  | ChangeMarkdown String
  | ChangeCSS String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model
    ChangeMarkdown str -> {model | mdown = str}
    ChangeCSS str -> {model | css = str}

view : Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [text "Markdown:"]
    , textarea [ onInput address ChangeMarkdown ] []
    , h1 [] [text "CSS:"]
    , textarea [ onInput address ChangeCSS ] []
    , node "style" [] [text model.css]
    , h1 [] [text "Rendered:"]
    , Markdown.toHtml model.mdown
    , h1 [] [text "Model:"]
    , div [] [text (toString model)]
    ]

main : Signal Html
main = start
  { model = {mdown = "", css = ""}
  , update = update
  , view = view
  }
