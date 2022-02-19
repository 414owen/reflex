{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}

module Clock.Time
  ( seconds
  , minutes
  , hours
  ) where

import Data.Time.Clock
import Control.Monad.Fix
import Control.Monad.IO.Class
import Reflex.Dom.Core

type TimeM t m = 
  ( Monad m
  , MonadIO m
  , PerformEvent t m
  , TriggerEvent t m
  , MonadIO (Performable m)
  , PostBuild t m
  , MonadHold t m
  , MonadFix m
  )

diffTimeToSeconds :: DiffTime -> Integer
diffTimeToSeconds = (`div` 1000000000000) . diffTimeToPicoseconds

seconds :: TimeM t m => m (Dynamic t Float)
seconds = do
  time <- liftIO getCurrentTime
  secs <- clockLossy 1 time
  let res = ffor secs $ \tick -> utctDayTime $ _tickInfo_lastUTC tick
  pure $ fmap (fromIntegral . diffTimeToSeconds) res

minutes :: TimeM t m => m (Dynamic t Float)
minutes = fmap (fmap (/ 60)) seconds

hours :: TimeM t m => m (Dynamic t Float)
hours = fmap (fmap (/ 60)) minutes
