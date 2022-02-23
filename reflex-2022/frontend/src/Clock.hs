{-# LANGUAGE OverloadedStrings #-}

module Clock (clock) where

import Reflex.Dom.Core
import Clock.Frame
import Clock.Marks
import Clock.Hands

clock ::
  ( DomBuilder t m
  , Prerender t m
  ) => m ()
clock = elAttr "svg" ("viewbox" =: "0 0 100 100" <> "width" =: "400px") $ do
  frame
  marks
  hands
  pure ()
