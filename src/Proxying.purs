module Type.Proxying
  ( module Type.Proxying.Boolean
  , module Type.Proxying.Ordering
  , module Type.Proxying.Row
  , module Type.Proxying.RowList
  , module Type.Proxying.Symbol
  , module Type.Proxying.Type
  , module Type.Proxying.Type2
  , module Type.Proxying.Type3
  ) where

import Type.Proxying.Boolean (class BProxying, bProxy, reflectBoolean, reifyBoolean)
import Type.Proxying.Ordering (class OProxying, oProxy, reflectOrdering, reifyOrdering)
import Type.Proxying.Row (class RProxying, rProxy)
import Type.Proxying.RowList (class RLProxying, rlProxy)
import Type.Proxying.Symbol (class SProxying, reflectSymbol, reifySymbol, sProxy)
import Type.Proxying.Type (class TProxying, tProxy)
import Type.Proxying.Type2 (class T2Proxying, t2Proxy)
import Type.Proxying.Type3 (class T3Proxying, t3Proxy)
