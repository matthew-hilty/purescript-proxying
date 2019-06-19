module Test.Main where

import Prelude (Unit, discard)

import Effect (Effect)
import Test.Suites.BProxying (suites) as BProxying
import Test.Suites.OProxying (suites) as OProxying
import Test.Suites.SProxying (suites) as SProxying
import Test.Unit.Main (runTest)

main :: Effect Unit
main = runTest do
  BProxying.suites
  OProxying.suites
  SProxying.suites
