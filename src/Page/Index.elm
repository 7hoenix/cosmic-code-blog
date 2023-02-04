module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Element as Ui
import Element.Events as Events
import Element.Font as Font
import Head
import Head.Seo as Seo
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import UI
import UI.Button as Button
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Cosmic Code"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    Ui.column
        [ Ui.width Ui.fill
        , Ui.height Ui.fill
        , Ui.behindContent UI.spaceBackground
        ]
        [ render
        ]
        |> List.singleton
        |> View.page "Welcome"



---


render : Ui.Element msg
render =
    Ui.column
        [ Ui.centerX
        , Ui.centerY
        , Font.bold
        , Font.size 22
        , Ui.width Ui.fill
        , Ui.height Ui.fill
        , UI.amboyBlack

        -- , Ui.behindContent (character staticAssets.characterSelection)
        , Ui.padding 50
        ]
        [ description
        , buttons
        ]


buttons : Ui.Element msg
buttons =
    Ui.row
        [ Ui.width Ui.fill
        , Ui.paddingEach { top = 100, right = 0, left = 0, bottom = 50 }
        , Ui.height (Ui.fillPortion 1)
        ]
        -- [ Ui.el [ Ui.alignLeft ] (Button.new |> Button.withText "Begin" |> Button.withSemanticColor UI.Primary |> Button.withSize Button.Large |> Button.toHtml)
        [ Ui.el [ Ui.centerX ] (Button.new |> Button.withText "START" |> Button.withSemanticColor UI.Info |> Button.withSize Button.Large |> Button.toHtml)
        ]


description : Ui.Element msg
description =
    Ui.row
        [ Ui.centerY
        , Ui.centerX
        , Ui.width Ui.fill
        , Ui.height Ui.fill
        , Ui.paddingEach { top = 0, right = 0, left = 200, bottom = 0 }
        ]
        [ Ui.el
            [ Ui.width (Ui.fillPortion 2)
            , Ui.height (Ui.fillPortion 3)
            , Ui.paddingEach { top = 150, right = 0, left = 0, bottom = 50 }
            ]
            (Ui.column
                [ Ui.centerY
                , Ui.centerX
                ]
                [ characterName

                -- , characterHealth
                , characterDescription

                -- , characterScanImage
                ]
            )
        , Ui.el
            [ Ui.centerY
            , Ui.height (Ui.fillPortion 1)
            , Ui.width (Ui.fillPortion 3)
            ]
            Ui.none
        ]


marginBottom : Int -> Ui.Attribute msg
marginBottom bottom =
    Ui.paddingEach { top = 0, right = 0, left = 0, bottom = bottom }


marginBottomThing : Ui.Attribute msg
marginBottomThing =
    marginBottom 40


characterName : Ui.Element msg
characterName =
    Ui.el
        [ Font.color UI.yellow
        , Font.bold
        , Font.size 40
        , marginBottomThing
        ]
        (Ui.text "Cosmic Code!")


characterDescription : Ui.Element msg
characterDescription =
    UI.paragraph
        [ Font.color UI.white
        , Font.bold
        , Font.size 22
        , marginBottomThing
        ]
        [ Ui.text "Help Astro the Robot navigate through space by learning how to code." ]



-- character : String -> Ui.Element msg
-- character src =
--     Ui.row
--         -- [ centerY
--         [ Ui.width Ui.fill
--         ]
--         [ Ui.el [ Ui.width (fillPortion 3) ] Ui.none
--         , Ui.el
--             [ centerX
--             , centerY
--             , Ui.width (fillPortion 2)
--             -- , Font.alignRight
--             -- , Ui.moveDown 50
--             -- , Ui.alignRight
--             -- , Ui.width fill
--             ]
--             (Core.Ui.Robot.homescreenImage src)
--         ]
---
