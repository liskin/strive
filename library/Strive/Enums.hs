{-# LANGUAGE OverloadedStrings #-}

-- | Types for choosing an option from a limited set.
module Strive.Enums
  ( ActivityType (..)
  , ActivityZoneType (..)
  , AgeGroup (..)
  , ClubType (..)
  , FrameType (..)
  , Gender (..)
  , MeasurementPreference (..)
  , PhotoType (..)
  , Resolution (..)
  , ResourceState (..)
  , SegmentActivityType (..)
  , SeriesType (..)
  , SportType (..)
  , WeightClass (..)
  ) where

import Control.Applicative (empty)
import Data.Aeson (FromJSON, Value (Number, String), parseJSON)
import Data.Char (toLower, toUpper)
import Data.Text (unpack)
import Text.Read (readMaybe)

-- | An activity's type.
data ActivityType
  = Alpineski
  | Backcountryski
  | Hike
  | Iceskate
  | Inlineskate
  | Kitesurf
  | Nordicski
  | Ride
  | Rollerski
  | Run
  | Snowboard
  | Snowshoe
  | Swim
  | Walk
  | Windsurf
  | Workout
  deriving Show

instance FromJSON ActivityType where
  parseJSON (String "alpineski") = return Alpineski
  parseJSON (String "backcountryski") = return Backcountryski
  parseJSON (String "hike") = return Hike
  parseJSON (String "iceskate") = return Iceskate
  parseJSON (String "inlineskate") = return Inlineskate
  parseJSON (String "kitesurf") = return Kitesurf
  parseJSON (String "nordicski") = return Nordicski
  parseJSON (String "ride") = return Ride
  parseJSON (String "rollerski") = return Rollerski
  parseJSON (String "run") = return Run
  parseJSON (String "snowboard") = return Snowboard
  parseJSON (String "snowshoe") = return Snowshoe
  parseJSON (String "swim") = return Swim
  parseJSON (String "walk") = return Walk
  parseJSON (String "windsurf") = return Windsurf
  parseJSON (String "workout") = return Workout
  parseJSON _ = empty

-- | An activity zone's type.
data ActivityZoneType
  = HeartrateZone
  | PowerZone
  deriving Show

instance FromJSON ActivityZoneType where
  parseJSON (String "heartrate") = return HeartrateZone
  parseJSON (String "power") = return PowerZone
  parseJSON _ = empty

-- | An athlete's age group.
data AgeGroup
  = Ages0To24
  | Ages25To34
  | Ages35To44
  | Ages45To54
  | Ages55To64
  | Ages65Plus

instance Show AgeGroup where
  show Ages0To24 = "0_24"
  show Ages25To34 = "25_34"
  show Ages35To44 = "35_44"
  show Ages45To54 = "45_54"
  show Ages55To64 = "55_64"
  show Ages65Plus = "65_plus"

-- | A club's type.
data ClubType
  = CasualClub
  | Company
  | Other
  | RacingTeam
  | Shop
  deriving Show

instance FromJSON ClubType where
  parseJSON (String "casual_club") = return CasualClub
  parseJSON (String "company") = return Company
  parseJSON (String "other") = return Other
  parseJSON (String "racing_team") = return RacingTeam
  parseJSON (String "shop") = return Shop
  parseJSON _ = empty

-- | A bike's frame type.
data FrameType
  = CrossFrame
  | MountainFrame
  | RoadFrame
  | TimeTrialFrame
  deriving Show

instance FromJSON FrameType where
  parseJSON (Number 2) = return CrossFrame
  parseJSON (Number 1) = return MountainFrame
  parseJSON (Number 3) = return RoadFrame
  parseJSON (Number 4) = return TimeTrialFrame
  parseJSON _ = empty

-- | An athlete's gender.
data Gender
  = Female
  | Male

instance Show Gender where
  show Female = "F"
  show Male = "M"

instance FromJSON Gender where
  parseJSON (String "F") = return Female
  parseJSON (String "M") = return Male
  parseJSON _ = empty

-- | An athlete's measurement preference.
data MeasurementPreference
  = Feet
  | Meters
  deriving Show

instance FromJSON MeasurementPreference where
  parseJSON (String "feet") = return Feet
  parseJSON (String "meters") = return Meters
  parseJSON _ = empty

-- | A photo's type.
data PhotoType
  = InstagramPhoto
  deriving Show

instance FromJSON PhotoType where
  parseJSON (String "InstagramPhoto") = return InstagramPhoto
  parseJSON _ = empty

-- | A stream's resolution.
data Resolution
  = Low
  | Medium
  | High

instance Show Resolution where
  show Low = "low"
  show Medium = "medium"
  show High = "high"

instance FromJSON Resolution where
  parseJSON (String "low") = return Low
  parseJSON (String "medium") = return Medium
  parseJSON (String "high") = return High
  parseJSON _ = empty

-- | A resource's state.
data ResourceState
  = Meta
  | Summary
  | Detailed
  deriving Show

instance FromJSON ResourceState where
  parseJSON (Number 1) = return Meta
  parseJSON (Number 2) = return Summary
  parseJSON (Number 3) = return Detailed
  parseJSON _ = empty

-- | A segment's activity type.
data SegmentActivityType
  = Riding
  | Running

instance Show SegmentActivityType where
  show Riding = "riding"
  show Running = "running"

-- | A series' type in a stream.
data SeriesType
  = Distance
  | Time

instance Show SeriesType where
  show Distance = "distance"
  show Time = "time"

instance FromJSON SeriesType where
  parseJSON (String "distance") = return Distance
  parseJSON (String "time") = return Time
  parseJSON _ = empty

-- | A club's sport type.
data SportType
  = SportCycling
  | SportOther
  | SportRunning
  | SportTriathalon
  deriving Show

instance FromJSON SportType where
  parseJSON (String "cycling") = return SportCycling
  parseJSON (String "other") = return SportOther
  parseJSON (String "running") = return SportRunning
  parseJSON (String "triathalon") = return SportTriathalon
  parseJSON _ = empty

-- | An athlete's weight class.
data WeightClass
  = Kilograms0To54
  | Kilograms55To64
  | Kilograms65To74
  | Kilograms75To84
  | Kilograms85To94
  | Kilograms95Plus
  | Pounds0To124
  | Pounds125To149
  | Pounds150To164
  | Pounds165To179
  | Pounds180To199
  | Pounds200Plus

instance Show WeightClass where
  show Kilograms0To54 = "0_54"
  show Kilograms55To64 = "55_64"
  show Kilograms65To74 = "65_74"
  show Kilograms75To84 = "75_84"
  show Kilograms85To94 = "85_94"
  show Kilograms95Plus = "95_plus"
  show Pounds0To124 = "0_124"
  show Pounds125To149 = "125_149"
  show Pounds150To164 = "150_164"
  show Pounds165To179 = "165_179"
  show Pounds180To199 = "180_199"
  show Pounds200Plus = "200_plus"
