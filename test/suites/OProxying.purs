module Test.Suites.OProxying
  ( suites
  ) where

import Prelude (discard)

import Data.Generic.Rep (class Generic)
import Data.Ordering (Ordering(EQ, GT, LT))
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (shouldEqual)
import Type.Data.Ordering (EQ, GT, LT, OProxy(OProxy), kind Ordering)
import Type.Proxying.Ordering (reflectOrdering)

data BespokeOProxy (o :: Ordering) = BespokeOProxy
derive instance genericBespokeOProxy :: Generic (BespokeOProxy o) _

suites :: TestSuite
suites =
  suite "OProxying" do
    test "Standard OProxy -- EQ" do
      reflectOrdering (OProxy :: OProxy EQ) `shouldEqual` EQ
    test "Standard OProxy -- GT" do
      reflectOrdering (OProxy :: OProxy GT) `shouldEqual` GT
    test "Standard OProxy -- LT" do
      reflectOrdering (OProxy :: OProxy LT) `shouldEqual` LT
    test "Bespoke symbol proxy -- EQ" do
      reflectOrdering (BespokeOProxy :: BespokeOProxy EQ) `shouldEqual` EQ
    test "Bespoke symbol proxy -- GT" do
      reflectOrdering (BespokeOProxy :: BespokeOProxy GT) `shouldEqual` GT
    test "Bespoke symbol proxy -- LT" do
      reflectOrdering (BespokeOProxy :: BespokeOProxy LT) `shouldEqual` LT
