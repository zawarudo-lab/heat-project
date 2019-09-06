module View where

import           Miso
import qualified Style.Global
import           Types
import           Utils
--import           Network.URI

view :: Model -> View Event
view model = case uriPath model.uri of
    "/"  -> root
    ""   -> root
    "/about" -> button_ [ onClick $ ChangeURI $ changer "" ] [ "WRIIIIIIIIII" ]
    "/about/company" -> label_ [ onClick $ ChangeURI $ changer "" ] [ "HAAA" ]
    _ -> text $ "404 page" <> mshow model.uri
  where
    root = div_ []
        [ maybeStyle model.files.normalizeCss
        , maybeStyle . Just $ Style.Global.css
        , h1_ [] [ "Test" ]
        , label_ [ onClick $ ChangeURI $ changer "about/company" ] [ text $ mshow model.uri ]
        , p_ [] [ text $ mshow $ uriFragment uri ]
        ]
    uri = model.uri
    changer path =
        let scheme = uriScheme uri
            authority = uriAuthority uri
            fragment = uriFragment uri
            query = uriQuery uri
        in URI scheme authority path query fragment

