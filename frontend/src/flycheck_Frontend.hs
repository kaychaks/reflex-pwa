{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}
module Frontend where

import qualified Data.Text                as T
import           Obelisk.Frontend
import           Obelisk.Route
import           Reflex.Dom.Core

import           Common.Api
import           Common.Route
import           Obelisk.Generated.Static
 


frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      elAttr "meta" ("charset" =: "utf-8") blank

      elAttr "meta" ("name" =: "viewport" <>
                     "content" =: "width=device-width, initial-scale=1, shrink-to-fit=no") blank

      elAttr "link" (
        "href" =: "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" <>
        "rel" =: "stylesheet" <>
        "integrity" =: "sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" <>
        "crossorigin" =: "anonymous"
        ) blank

      elAttr "link" (
        "rel" =: "manifest" <>
        "href" =: "/manifest.json"
        ) blank

      el "title" $ text "Obelisk Minimal Example"
  , _frontend_body = do
      text "Welcome to Obelisk!"
      el "p" $ text $ T.pack commonStuff
      elAttr "img" ("src" =: static @"obelisk.jpg") blank

      
  }
