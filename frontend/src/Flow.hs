{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TupleSections #-}

module Flow (flow) where

import Control.Category ((>>>))
import Control.Monad
import Control.Monad.Fix

import Data.Functor
import Data.Map (Map)
import qualified Data.Map as M
import Data.Text (Text)
import Reflex.Dom.Core

import Clock.Util

type FlowM t m = 
  ( DomBuilder t m
  , MonadHold t m
  , MonadFix m
  , PostBuild t m
  )


down :: FlowM t m => m ()
down = do
  -- Button to click
  click <- button "Increment number below"
  -- Map click even to count (Dynamic t Int)
  n :: Dynamic t Int <- count click
  -- Display click count
  el "div" $ dynText $ fmap tshow n


up :: FlowM t m => m ()
up = mdo
  -- Map click even to count (Dynamic t Int)
  n :: Dynamic t Int <- count click
  -- Display click count
  el "div" $ dynText $ fmap tshow n
  -- Button to click
  click <- button "Increment number above"
  pure ()


buttonDynText :: FlowM t m => Dynamic t Text -> m (Event t ())
buttonDynText dtext = do
  a <- dyn $ ffor dtext $ \t -> button t
  switchHold mempty a


mutual :: FlowM t m => m ()
mutual = mdo
  clickA <- el "div" $
    buttonDynText $ fmap (("Clicks below: " <>) . tshow) b
  clickB <- el "div" $
    buttonDynText $ fmap (("Clicks above: " <>) . tshow) a
  a :: Dynamic t Int <- count clickA
  b :: Dynamic t Int <- count clickB
  pure ()


data Player = X | O

boolToPlayer :: Bool -> Player
boolToPlayer True = X
boolToPlayer False = O


game :: FlowM t m => m ()
game = mdo
  turnDyn <- ffor (toggle False click) $ fmap boolToPlayer
  state <- foldDyn
    (\(turn, (x, y)) m -> M.insert (x, y) turn m)
    mempty $ attachPromptlyDyn turnDyn click
  click <- fmap leftmost $ forM [1..3] $ \x -> do
    el "div" $ 
      fmap leftmost $ forM [1..3] $ \y -> do
        clickEv <- buttonDynText $ ffor state $ \s -> case M.lookup (x, y) s of
          Nothing -> "⠀"
          Just X -> "X"
          Just O -> "O"
        pure $ clickEv $> (x, y)
  pure ()


flow :: FlowM t m => m ()
flow = do
  -- down
  -- up
  -- mutual
  -- game
  pure ()

  -- The monad renders elements top-to-bottom

  {-
  el "div" $ text "one"
  el "div" $ text "two"
  el "div" $ text "three"
  -}


  -- Becomes
  {-
  <div>one</div>
  <div>two</div>
  <div>three</div>
  -}
