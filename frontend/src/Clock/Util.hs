{-# LANGUAGE OverloadedStrings #-}

module Clock.Util
  ( rotate
  , tshow
  , Ats
  , vertical
  ) where

import Reflex.Dom.Core
import Data.Text (Text, pack)
import Data.Map (Map)

type Ats = Map Text Text

vertical :: Ats
vertical = "x1" =: "50" <> "x2" =: "50"

tshow :: Show a => a -> Text
tshow = pack . show

rotate :: Show a => a -> Map Text Text
rotate degs = "transform" =: ("rotate(" <> tshow degs <> " 50 50)")
