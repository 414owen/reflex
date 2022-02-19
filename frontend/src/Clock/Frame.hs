{-# LANGUAGE OverloadedStrings #-}

module Clock.Frame (frame) where

import Reflex.Dom.Core

frame :: DomBuilder t m => m ()
frame = do
  elAttr "circle" ("r" =: "50" <> "cx" =: "50" <> "cy" =: "50") $ pure ()
  elAttr "circle" ("fill" =: "white" <> "r" =: "45" <> "cx" =: "50" <> "cy" =: "50") $ pure ()
  elAttr "circle" ("fill" =: "black" <> "r" =: "2" <> "cx" =: "50" <> "cy" =: "50") $ pure ()
