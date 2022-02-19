{-# LANGUAGE OverloadedStrings #-}

module Talk (talk) where

import Control.Monad.Fix
import Reflex.Dom.Core

import Clock
import Flow


talk ::
  ( DomBuilder t m
  , Prerender t m
  , MonadFix m
  , MonadHold t m
  , PostBuild t m
  ) => m ()
talk = do
  clock
  -- el "div" $ flow
