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
  Generic (f s) rep
  <= GenericTProxying (rep :: Type) (f :: Type -> Type) (s :: Type)
  where
  genericTProxy :: Proxy rep ->  f s

instance genericTProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericTProxying (Constructor proxyName NoArguments) f s
  where
  genericTProxy _ = to (Constructor NoArguments)

class TProxying (f :: Type -> Type) (a :: Type) where
  tProxy :: f a

instance tProxyingProxy :: TProxying Proxy a where
  tProxy = Proxy

else instance tProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => TProxying f s
  where
  tProxy = genericTProxy (Proxy :: Proxy (Constructor proxyName NoArguments))
