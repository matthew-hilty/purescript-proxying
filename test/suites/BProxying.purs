module Test.Suites.BProxying
  ( suites
  ) where

import Prelude (discard)

import Data.Generic.Rep (class Generic)
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (shouldEqual)
import Type.Data.Boolean (BProxy(BProxy), False, True, kind Boolean)

import Type.Proxying.Boolean (reflectBoolean)

data BespokeBProxy (o :: Boolean) = BespokeBProxy
derive instance genericBespokeBProxy :: Generic (BespokeBProxy o) _

suites :: TestSuite
suites =
  suite "BProxying" do
    test "Standard BProxy -- True" do
      reflectBoolean (BProxy :: BProxy True) `shouldEqual` true
    test "Standard BProxy -- False" do
      reflectBoolean (BProxy :: BProxy False) `shouldEqual` false
    test "Bespoke symbol proxy -- True" do
      reflectBoolean (BespokeBProxy :: BespokeBProxy True) `shouldEqual` true
    test "Bespoke symbol proxy -- False" do
      reflectBoolean (BespokeBProxy :: BespokeBProxy False) `shouldEqual` false
