module View exposing (View, map, page)

import Element as Ui


type alias View msg =
    { title : String
    , body : List (Ui.Element msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Ui.map fn) doc.body
    }


page : String -> List (Ui.Element msg) -> View msg
page moduleName body =
    { title = "Cosmic Code - " ++ moduleName
    , body = body
    }
