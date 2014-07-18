{-# LANGUAGE OverloadedStrings #-}

module Strive.Types.Authentication
  ( TokenExchangeResponse (..)
  , DeauthorizationResponse (..)
  ) where

import Control.Applicative (empty, (<$>), (<*>))
import Data.Aeson (FromJSON, Value (Object), parseJSON, (.:))
import Data.Text (Text)
import Strive.Types.Athletes (AthleteDetailed)

-- | <http://strava.github.io/api/v3/oauth/#example-response>
data TokenExchangeResponse = TokenExchangeResponse
  { tokenExchangeResponse_accessToken :: Text
  , tokenExchangeResponse_athlete     :: AthleteDetailed
  } deriving Show

instance FromJSON TokenExchangeResponse where
  parseJSON (Object o) = TokenExchangeResponse
    <$> o .: "access_token"
    <*> o .: "athlete"
  parseJSON _ = empty

-- | <http://strava.github.io/api/v3/oauth/#example-response-1>
data DeauthorizationResponse = DeauthorizationResponse
  { deauthorizationResponse_accessToken :: Text
  } deriving Show

instance FromJSON DeauthorizationResponse where
  parseJSON (Object o) = DeauthorizationResponse
    <$> o .: "access_token"
  parseJSON _ = empty