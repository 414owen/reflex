{-# LANGUAGE OverloadedStrings #-}

module Clock.Util
  ( rotate
  , tshow
  , Ats
  ) where

import Reflex.Dom.Core
import Data.Text (Text, pack)
import Data.Map (Map)

type Ats = Map Text Text

tshow :: Show a => a -> Text
tshow = pack . show

rotate :: Show a => a -> Map Text Text
rotate degs = "transform" =: ("rotate(" <> tshow degs <> " 50 50)")
