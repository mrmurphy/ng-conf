module Main (..) where

import Html exposing (..)
import StartApp.Simple as StartApp exposing (start)
import Signal exposing (Address)
import EasyEvents exposing (onInput)
import Markdown

type Action
  = NoOp
  | UpdateMarkdown String

type alias Model = String

model : Model
model = ""

update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model
    UpdateMarkdown str -> str

view : Address Action -> Model -> Html
view address model =
  div []
    [ textarea [onInput address UpdateMarkdown] []
    , h1 [] [ text "Markdown:" ]
    , Markdown.toHtml model
    , h1 [] [ text "Model:" ]
    , text (toString model) ]

main : Signal Html
main = start
  { model = model
  , update = update
  , view = view
  }
