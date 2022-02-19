{-# LANGUAGE OverloadedStrings #-}

module Frontend where

import Obelisk.Frontend
import Obelisk.Route
import Reflex.Dom.Core
import Common.Route

import Clock

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = el "title" $ text "Obelisk Minimal Example"
  , _frontend_body = clock
  }
