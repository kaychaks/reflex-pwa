{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE EmptyCase         #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TypeFamilies      #-}
module Backend where

import           Common.Route
import           Data.Aeson
import           Data.Bool             (bool)
import           Data.Char             (toLower)
import           Data.Dependent.Sum    (DSum (..))
import           Data.Functor.Identity
import           Data.Text             (Text)
import           GHC.Generics
import           Obelisk.Backend
import           Snap.Internal.Core

data Display = FullScreen | Standalone | Minimal_UI | Browser deriving (Show , Generic)
instance ToJSON Display where
  toEncoding = genericToEncoding $ defaultOptions {constructorTagModifier = map ( (\e -> bool e '-' (e == '_')) . toLower )}

data Manifest = Manifest  {
    name          :: Text
    , short_name  :: Text
    , start_url   :: Text
    , display     :: Display
    , description :: Text
    } deriving (Show, Generic)
instance ToJSON Manifest where
  toEncoding = genericToEncoding defaultOptions

manifest :: Manifest
manifest = Manifest "Test" "Test" "/" Minimal_UI "Test Desc"

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> serve $ \b -> case b of
      BackendRoute_Missing :=> Identity ()  -> pass
      BackendRoute_Manifest :=> Identity () -> writeLBS $ encode manifest
  , _backend_routeEncoder = backendRouteEncoder
  }
