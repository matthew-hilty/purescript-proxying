module Type.Proxying.Type
  ( class GenericTProxying
  , class TProxying
  , genericTProxy
  , tProxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Proxy (Proxy(Proxy))

class
  Generic (f t) rep
  <= GenericTProxying (rep :: Type) (f :: Type -> Type) (t :: Type)
  where
  genericTProxy :: Proxy rep ->  f t

instance genericTProxyingConstructor
  :: Generic (f t) (Constructor proxyName NoArguments)
  => GenericTProxying (Constructor proxyName NoArguments) f t
  where
  genericTProxy _ = to (Constructor NoArguments)

class TProxying (f :: Type -> Type) (a :: Type) where
  tProxy :: f a

instance tProxyingProxy :: TProxying Proxy a where
  tProxy = Proxy

else instance tProxyingGeneric
  :: Generic (f t) (Constructor proxyName NoArguments)
  => TProxying f t
  where
  tProxy = genericTProxy (Proxy :: Proxy (Constructor proxyName NoArguments))
