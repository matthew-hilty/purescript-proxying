module Type.Proxying.RowList
  ( class GenericRLProxying
  , class RLProxying
  , genericRLProxy
  , rlProxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Prim.RowList (kind RowList)
import Type.Data.RowList (RLProxy(RLProxy)) as TypeDataRowList
import Type.Proxy (Proxy(Proxy))
import Type.Row (RLProxy(RLProxy)) as TypeRow

class
  Generic (f s) rep
  <= GenericRLProxying (rep :: Type) (f :: RowList -> Type) (s :: RowList)
  where
  genericRLProxy :: Proxy rep ->  f s

instance genericRLProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericRLProxying (Constructor proxyName NoArguments) f s
  where
  genericRLProxy _ = to (Constructor NoArguments)

class RLProxying (f :: RowList -> Type) (s :: RowList) where
  rlProxy :: f s

instance rlProxying_TypeDataRowList_RLProxy
  :: RLProxying TypeDataRowList.RLProxy l
  where
  rlProxy = TypeDataRowList.RLProxy

else instance rlProxying_TypeRow_RLProxy
  :: RLProxying TypeRow.RLProxy l
  where
  rlProxy = TypeRow.RLProxy

else instance rlProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => RLProxying f s
  where
  rlProxy = genericRLProxy (Proxy :: Proxy (Constructor proxyName NoArguments))
