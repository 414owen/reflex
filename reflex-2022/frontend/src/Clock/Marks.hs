{-# LANGUAGE OverloadedStrings #-}

module Clock.Marks (marks) where

import Control.Monad
import Data.Text (Text)
import Reflex.Dom.Core

import Clock.Util

mark :: DomBuilder t m => Text -> Text -> Int -> m ()
mark len width minute =
  elAttr "line"
    ( "stroke" =: "black"
    <> "stroke-width" =: width
    <> rotate (minute * 360 `div` 60)
    <> "x1" =: "50"
    <> "x2" =: "50"
    <> "y1" =: "3"
    <> "y2" =: len
    ) $ pure ()

marks :: DomBuilder t m => m ()
marks = do
  forM_ [1..60] $ mark "7" "1"
  forM_ ((5 *) <$> [1..12]) $ mark "10" "2"
