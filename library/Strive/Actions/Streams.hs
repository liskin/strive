-- | <http://strava.github.io/api/v3/streams/>
module Strive.Actions.Streams
  ( getActivityStreams
  , getEffortStreams
  , getSegmentStreams
  ) where

import Data.Aeson (FromJSON)
import Data.List (intercalate)
import Network.HTTP.Types (toQuery)
import Strive.Aliases (Result)
import Strive.Client (Client)
import Strive.Enums (StreamType)
import Strive.Internal.HTTP (get)
import Strive.Options (GetStreamsOptions)
import Strive.Types (StreamDetailed)

-- | <http://strava.github.io/api/v3/streams/#activity>
getActivityStreams :: Client -> Integer -> [StreamType] -> GetStreamsOptions -> Result [StreamDetailed]
getActivityStreams = flip getStreams "activities"

-- | <http://strava.github.io/api/v3/streams/#effort>
getEffortStreams :: Client -> Integer -> [StreamType] -> GetStreamsOptions -> Result [StreamDetailed]
getEffortStreams = flip getStreams "segment_efforts"

-- | <http://strava.github.io/api/v3/streams/#segment>
getSegmentStreams :: Client -> Integer -> [StreamType] -> GetStreamsOptions -> Result [StreamDetailed]
getSegmentStreams = flip getStreams "segments"

getStreams :: FromJSON a => Client -> String -> Integer -> [StreamType] -> GetStreamsOptions -> Result a
getStreams client kind id_ types options = get client resource query
  where
    resource = concat
        [ "api/v3/"
        , kind
        , "/"
        , show id_
        , "/streams/"
        , intercalate "," (map show types)
        ]
    query = toQuery options
