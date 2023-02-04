module UI exposing (..)

{- This module is pieces of the actual app.

   It will get painful if we don't use something better for code sharing

-}

import Element as Ui
import Element.Font as Font


type SemanticColor
    = Primary
    | Info
    | Accent



-----------------
-- Backgrounds --
-----------------


spaceBackground : Ui.Element msg
spaceBackground =
    Ui.image
        [ Ui.width Ui.fill
        , Ui.height Ui.fill
        ]
        { src = "images/star-map-background.svg", description = "Space." }


paragraph : List (Ui.Attribute msg) -> List (Ui.Element msg) -> Ui.Element msg
paragraph additionalAttributes =
    Ui.paragraph (additionalAttributes ++ [ robotoFlex, Font.medium ])



-- FONTS


robotoFlex : Ui.Attribute msg
robotoFlex =
    Font.family
        [ Font.typeface "Roboto Flex"
        , Font.sansSerif
        ]


amboyBlack : Ui.Attribute msg
amboyBlack =
    Font.family
        [ Font.typeface "amboy-black"
        , Font.sansSerif
        ]



-- Colors


white : Ui.Color
white =
    Ui.rgb255 255 255 255


gray : Ui.Color
gray =
    Ui.rgb255 200 200 200



-- Approved colors


black : Ui.Color
black =
    Ui.rgb255 5 1 40


purple : Ui.Color
purple =
    Ui.rgb255 149 116 255



--differentGreen : Ui.Color
--differentGreen =
--    Ui.rgb255 65 221 220


teal : Ui.Color
teal =
    Ui.rgb255 47 245 225


red : Ui.Color
red =
    Ui.rgb255 251 89 172


darkRed : Ui.Color
darkRed =
    Ui.rgb255 227 50 41


blue : Ui.Color
blue =
    Ui.rgb255 19 61 123


neonBlue : Ui.Color
neonBlue =
    Ui.rgb255 52 172 233


mountainBlue : Ui.Color
mountainBlue =
    Ui.rgb255 153 182 255


lightBlue : Ui.Color
lightBlue =
    Ui.rgb255 122 169 218


yellow : Ui.Color
yellow =
    Ui.rgb255 229 199 18


darkerGray : Ui.Color
darkerGray =
    Ui.rgb255 39 38 39


{-| Paired with its opposite for contrast
-}
darkGray : Ui.Color
darkGray =
    Ui.rgb255 49 57 65


{-| Paired with its opposite for contrast
-}
darkGrayOpposite : Ui.Color
darkGrayOpposite =
    Ui.rgb255 197 239 247


lightGray : Ui.Color
lightGray =
    Ui.rgb255 73 81 99
