module Test.Suites.SProxying
  ( suites
  ) where

import Prelude (discard)

import Data.Generic.Rep (class Generic)
import Data.Symbol (SProxy(SProxy))
import Test.Unit.Assert (shouldEqual)
import Test.Unit (TestSuite, suite, test)
import Type.Proxying.Symbol (reflectSymbol)

data BespokeSProxy (s :: Symbol) = BespokeSProxy
derive instance genericBespokeSProxy :: Generic (BespokeSProxy s) _

suites :: TestSuite
suites =
  suite "SProxying" do
    test "Standard SProxy" do
      reflectSymbol (SProxy :: SProxy "a0") `shouldEqual` "a0"
    test "Bespoke symbol proxy" do
      reflectSymbol (BespokeSProxy :: BespokeSProxy "a0") `shouldEqual` "a0"
