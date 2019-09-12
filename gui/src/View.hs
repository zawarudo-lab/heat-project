module View where

import           Miso
import qualified Style.Global
import           Types
import           Utils
import qualified View.Header
import qualified View.Content
import qualified View.About
import qualified View.ObogrevKrovli
import qualified View.ObogrevPloshadi
import qualified View.ObogrevTruboprovoda

view :: Model -> View Event
view model = div_ []
    [ maybeStyle model.files.normalizeCss
    , maybeStyle . Just $ Style.Global.css model
    , if model.device == Mobile && model.shouldShowMenu 
        then div_ [] 
            [ div_ [class_ "menuMob"]
                $ map
                (\x -> div_
                    [ class_ "menu-item-mob"
                    , onClick $ Batch [PopOr, SwitchMenu, changeRoute x.routePath model.uri]
                    ] [label_ [class_ "menuMes"] [text x.label]]
                ) menu
            ]
        else ""
    , div_ [] [View.Header.render model]
    , curRoute
    ]
  where
    curRoute = case uriToRouteString model.uri of
        ""               -> View.Content.render model
        "about"          -> View.About.render model
        "planning"       -> text $ mshow model.uri 
        "montage"        -> text $ mshow model.uri 
        "individ-proj"   -> text $ mshow model.uri 
        "about/company"  -> "about company page"
        "obogrev-krovli" -> View.ObogrevKrovli.render model
        "obogrev-truboprovoda" -> View.ObogrevTruboprovoda.render model
        "obogrev-ploshadi" -> View.ObogrevPloshadi.render model
        _                -> "404 page"
