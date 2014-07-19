-- | Types and functions for dealing with the API client itself.
module Strive.Client
  ( Client (..)
  , buildClient
  ) where

import Data.ByteString.Lazy (ByteString)
import Network.HTTP.Client.Conduit (newManager)
import Network.HTTP.Conduit (Manager, Request, Response, httpLbs)

-- | Strava V3 API client.
data Client = Client
  { client_accessToken :: String
  , client_requester   :: Request -> IO (Response ByteString)
  }

instance Show Client where
  show client = concat
    [ "Client {client_accessToken = "
    , show (client_accessToken client)
    , "}"
    ]

-- | Build a new client using the default HTTP manager to make requests.
buildClient :: String -> IO Client
buildClient accessToken = do
  manager <- newManager
  return Client
    { client_accessToken = accessToken
    , client_requester   = flip httpLbs manager
    }
