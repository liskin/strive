{-# LANGUAGE OverloadedStrings #-}

-- | Functions for performing actions against the API.
module Strive.Actions
    ( getActivity
    , getAthlete
    , getAthleteCRs
    , getComments
    , getCommonFriends
    , getCurrentActivities
    , getCurrentAthlete
    , getCurrentFollowers
    , getCurrentFriends
    , getFollowers
    , getFriends
    , getFriendsActivities
    , getKudoers
    , getLaps
    , getPhotos
    , getZones
    , module Actions
    ) where

import           Data.Aeson              (encode)
import           Data.ByteString.Char8   (pack)
import           Data.ByteString.Lazy    (toStrict)
import           Data.Monoid             ((<>))
import           Data.Time.Clock         (UTCTime)
import           Data.Time.Clock.POSIX   (utcTimeToPOSIXSeconds)
import           Strive.Actions.Clubs    as Actions
import           Strive.Actions.Efforts  as Actions
import           Strive.Actions.Gear     as Actions
import           Strive.Actions.Internal (get, paginate)
import           Strive.Actions.Segments as Actions
import           Strive.Client           (Client)
import qualified Strive.Objects          as Objects
import qualified Strive.Types            as Types

-- | <http://strava.github.io/api/v3/activities/#get-details>
getActivity :: Client -> Types.ActivityId -> Maybe Bool -> IO (Either String Objects.ActivitySummary)
getActivity client activityId allEfforts = get client resource query
  where
    resource = "activities/" <> show activityId
    query = case allEfforts of
        Just flag -> [("include_all_efforts", toStrict (encode flag))]
        _ -> []

-- | <http://strava.github.io/api/v3/athlete/#get-another-details>
getAthlete :: Client -> Types.AthleteId -> IO (Either String Objects.AthleteSummary)
getAthlete client athleteId = get client resource query
  where
    resource = "athletes/" <> show athleteId
    query = []

-- | <http://strava.github.io/api/v3/athlete/#koms>
getAthleteCRs :: Client -> Types.AthleteId -> Types.Page -> Types.PerPage -> IO (Either String [Objects.EffortSummary])
getAthleteCRs client athleteId page perPage = get client resource query
  where
    resource = "athletes/" <> show athleteId <> "/koms"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/comments/#list>
getComments :: Client -> Types.ActivityId -> Types.IncludeMarkdown -> Types.Page -> Types.PerPage -> IO (Either String [Objects.CommentSummary])
getComments client activityId includeMarkdown page perPage = get client resource query
  where
    resource = "activities/" <> show activityId <> "/comments"
    query = ("markdown", toStrict (encode includeMarkdown)) : paginate page perPage

-- | <http://strava.github.io/api/v3/follow/#both>
getCommonFriends :: Client -> Types.AthleteId -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getCommonFriends client athleteId page perPage = get client resource query
  where
    resource = "athletes/" <> show athleteId <> "/both-following"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/activities/#get-activities>
getCurrentActivities :: Client -> Maybe UTCTime -> Maybe UTCTime -> Types.Page -> Types.PerPage -> IO (Either String [Objects.ActivitySummary])
getCurrentActivities client before after page perPage = get client resource query
  where
    resource = "athlete/activities"
    query = paginate page perPage <> go
        [ ("before", fmap (pack . show . utcTimeToPOSIXSeconds) before)
        , ("after", fmap (pack . show . utcTimeToPOSIXSeconds) after)
        ]
    go [] = []
    go ((_, Nothing) : xs) = go xs
    go ((k, Just v) : xs) = (k, v) : go xs

-- | <http://strava.github.io/api/v3/athlete/#get-details>
getCurrentAthlete :: Client -> IO (Either String Objects.AthleteDetailed)
getCurrentAthlete client = get client resource query
  where
    resource = "athlete"
    query = []

-- | <http://strava.github.io/api/v3/follow/#followers>
getCurrentFollowers :: Client -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getCurrentFollowers client page perPage = get client resource query
  where
    resource = "athlete/followers"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/follow/#friends>
getCurrentFriends :: Client -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getCurrentFriends client page perPage = get client resource query
  where
    resource = "athlete/friends"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/follow/#followers>
getFollowers :: Client -> Types.AthleteId -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getFollowers client athleteId page perPage = get client resource query
  where
    resource = "athletes/" <> show athleteId <> "/followers"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/follow/#friends>
getFriends :: Client -> Types.AthleteId -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getFriends client athleteId page perPage = get client resource query
  where
    resource = "athletes/" <> show athleteId <> "/friends"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/activities/#get-feed>
getFriendsActivities :: Client -> Types.Page -> Types.PerPage -> IO (Either String [Objects.ActivitySummary])
getFriendsActivities client page perPage = get client resource query
  where
    resource = "activities/following"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/activities/#laps>
getLaps :: Client -> Types.ActivityId -> IO (Either String [Objects.EffortLap])
getLaps client activityId = get client resource query
  where
    resource = "activities/" <> show activityId <> "/laps"
    query = []

-- | <http://strava.github.io/api/v3/kudos/#list>
getKudoers :: Client -> Types.ActivityId -> Types.Page -> Types.PerPage -> IO (Either String [Objects.AthleteSummary])
getKudoers client activityId page perPage = get client resource query
  where
    resource = "activities/" <> show activityId <> "/kudos"
    query = paginate page perPage

-- | <http://strava.github.io/api/v3/photos/#list>
getPhotos :: Client -> Types.ActivityId -> IO (Either String [Objects.PhotoSummary])
getPhotos client activityId = get client resource query
  where
    resource = "activities/" <> show activityId <> "/photos"
    query = []

-- | <http://strava.github.io/api/v3/activities/#zones>
getZones :: Client -> Types.ActivityId -> IO (Either String [Objects.ZoneSummary])
getZones client activityId = get client resource query
  where
    resource = "activities/" <> show activityId <> "/zones"
    query = []