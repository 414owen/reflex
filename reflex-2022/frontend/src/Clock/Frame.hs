{-# LANGUAGE OverloadedStrings #-}

module Clock.Frame (frame) where

import Data.Text (Text)
import Data.Map (Map)
import Reflex.Dom.Core

center :: Map Text Text
center = "cx" =: "50" <> "cy" =: "50"

frame :: DomBuilder t m => m ()
frame = do

  elAttr "circle"
      ( center
      <> "fill" =: "none"
      <> "stroke" =: "black"
      <> "stroke-width" =: "4"
      <> "r" =: "48"
      ) $ pure ()

  elAttr "circle" (center <> "r" =: "2") $ pure ()
