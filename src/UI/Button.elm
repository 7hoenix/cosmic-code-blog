module UI.Button exposing
    ( Button
    , Size(..)
    , new
    , primaryButton
    , toHtml
    , withContent
    , withHandler
    , withHandlerFromMaybe
    , withIcon
    , withSemanticColor
    , withSize
    , withText
    )

import Element as Ui
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import UI as UI exposing (SemanticColor)


type Button msg
    = Button
        { buttonContent : Ui.Element msg
        , clickHandler : Handler msg
        , color : SemanticColor
        , size : Size
        }


type Size
    = Large
    | Normal


type Handler msg
    = Disabled
    | Available msg


new : Button msg
new =
    Button
        { buttonContent = Ui.el [] (Ui.text "Fill me in")
        , clickHandler = Disabled
        , color = UI.Accent
        , size = Normal
        }



-- Defaults


primaryButton : msg -> String -> Button msg
primaryButton clickHandler content =
    new
        |> withText content
        |> withSemanticColor UI.Primary
        |> withHandler clickHandler



-- Builders


withText : String -> Button msg -> Button msg
withText buttonText (Button internal) =
    Button { internal | buttonContent = Ui.el [ Ui.padding 10 ] (Ui.text buttonText) }


withSize : Size -> Button msg -> Button msg
withSize size (Button internal) =
    Button { internal | size = size }


withContent : Ui.Element msg -> Button msg -> Button msg
withContent buttonContent (Button internal) =
    Button { internal | buttonContent = buttonContent }


withIcon : Ui.Element msg -> Button msg -> Button msg
withIcon buttonContent (Button internal) =
    Button { internal | buttonContent = buttonContent }


withSemanticColor : SemanticColor -> Button msg -> Button msg
withSemanticColor color (Button internal) =
    Button { internal | color = color }


withHandler : msg -> Button msg -> Button msg
withHandler handler (Button internal) =
    Button { internal | clickHandler = Available handler }


withHandlerFromMaybe : Maybe msg -> Button msg -> Button msg
withHandlerFromMaybe maybe (Button internal) =
    let
        handler =
            case maybe of
                Nothing ->
                    Disabled

                Just a ->
                    Available a
    in
    Button { internal | clickHandler = handler }


type alias GradientColorScheme =
    { light : MathableColor
    , dark : MathableColor
    , border : MathableColor
    , font : MathableColor
    }


yellowGradientColorScheme : GradientColorScheme
yellowGradientColorScheme =
    { light = MathableColor { red = 252, green = 254, blue = 168 }
    , dark = MathableColor { red = 255, green = 234, blue = 108 }
    , border = MathableColor { red = 253, green = 227, blue = 137 }
    , font = MathableColor { red = 52, green = 53, blue = 105 }
    }


blueGradientColorScheme : GradientColorScheme
blueGradientColorScheme =
    { light = MathableColor { red = 180, green = 212, blue = 254 }
    , dark = MathableColor { red = 157, green = 187, blue = 254 }
    , border = MathableColor { red = 146, green = 185, blue = 237 }
    , font = MathableColor { red = 255, green = 255, blue = 255 }
    }


type MathableColor
    = MathableColor { red : Int, green : Int, blue : Int }


clampStrand : Int -> Int
clampStrand =
    clamp 0 255


withOffset : Int -> MathableColor -> MathableColor
withOffset offset (MathableColor { red, green, blue }) =
    MathableColor
        { red = clampStrand <| red + offset
        , green = clampStrand <| green + offset
        , blue = clampStrand <| blue + offset
        }


toColor : MathableColor -> Ui.Color
toColor (MathableColor { red, blue, green }) =
    Ui.rgb255 red green blue


toHtml : Button msg -> Ui.Element msg
toHtml (Button { buttonContent, clickHandler, color, size }) =
    let
        gradient =
            case color of
                UI.Primary ->
                    yellowGradientColorScheme

                UI.Info ->
                    blueGradientColorScheme

                UI.Accent ->
                    blueGradientColorScheme

        shadowConfig =
            { offset = ( -1, -2 )
            , size = 0
            , blur = 0
            , color = toColor gradient.border
            }

        gradientColor =
            { angle = degrees 90
            , steps = [ toColor gradient.dark, toColor gradient.light ]
            }

        gradientColor2 offset =
            { angle = degrees 90
            , steps = [ toColor (withOffset offset gradient.dark), toColor (withOffset offset gradient.light) ]
            }

        sizeAttr =
            case size of
                Large ->
                    Ui.paddingXY 80 10

                Normal ->
                    Ui.padding 0
    in
    Ui.el []
        (Input.button
            ([ Background.gradient gradientColor
             , Border.rounded 5
             , Border.innerShadow shadowConfig
             , Font.color (toColor gradient.font)

             -- ok
             , Background.color (toColor gradient.font)

             -- , Ui.mouseOver [ Ui.alpha 0.6 ]
             , Ui.mouseDown
                [ Background.gradient gradientColor
                , Border.color (gradient.border |> toColor)
                , Font.color (gradient.font |> toColor)
                ]
             , Ui.mouseOver
                [ Background.gradient (gradientColor2 -30)
                , Border.color (gradient.border |> withOffset -30 |> toColor)
                , Font.color (gradient.font |> withOffset -30 |> toColor)
                ]
             , sizeAttr
             ]
             -- TODO: make it better.
             --[ Attr.type_ "button"
             --, css
             --    [ Tw.inline_flex
             --    , Tw.items_center
             --    , Tw.px_4
             --    , Tw.py_2
             --    , Tw.border
             --    , Tw.border_transparent
             --    , Tw.text_sm
             --    , Tw.font_medium
             --    , Tw.rounded_md
             --    , Tw.shadow_sm
             --    , Tw.text_white
             --    , dark
             --    , Css.focus
             --        [ Tw.outline_none
             --        , Tw.ring_2
             --        , Tw.ring_offset_2
             --        , ringLight
             --        ]
             --    , Css.hover
             --        [ darker
             --        ]
             --    , Css.disabled
             --        [ Tw.opacity_50 ]
             --    ]
             --]
            )
            { label = buttonContent
            , onPress = handlerToMaybe clickHandler
            }
        )


handlerToMaybe : Handler msg -> Maybe msg
handlerToMaybe handler =
    case handler of
        Disabled ->
            Nothing

        Available handler_ ->
            Just handler_
