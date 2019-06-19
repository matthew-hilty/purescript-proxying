module Type.Proxying.Row
  ( class GenericRProxying
  , class RProxying
  , genericRProxy
  , rProxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Data.Row (RProxy(RProxy)) as TypeDataRow
import Type.Row (RProxy(RProxy)) as TypeRow
import Type.Proxy (Proxy(Proxy))

class
  Generic (f s) rep
  <= GenericRProxying (rep :: Type) (f :: # Type -> Type) (s :: # Type)
  where
  genericRProxy :: Proxy rep ->  f s

instance genericRProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericRProxying (Constructor proxyName NoArguments) f s
  where
  genericRProxy _ = to (Constructor NoArguments)

class RProxying (f :: # Type -> Type) (r :: # Type) where
  rProxy :: f r

instance rProxying_TypeDataRow_RProxy :: RProxying TypeDataRow.RProxy r where
  rProxy = TypeDataRow.RProxy

else instance rProxying_TypeRow_RProxy :: RProxying TypeRow.RProxy r where
  rProxy = TypeRow.RProxy

else instance rProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => RProxying f s
  where
  rProxy = genericRProxy (Proxy :: Proxy (Constructor proxyName NoArguments))
