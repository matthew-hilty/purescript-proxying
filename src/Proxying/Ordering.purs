module Type.Proxying.Ordering
  ( class GenericOProxying
  , class OProxying
  , genericOProxy
  , oProxy
  , reflectOrdering
  , reifyOrdering
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Data.Ordering (Ordering(EQ, GT, LT))
import Type.Data.Ordering
  ( class IsOrdering
  , EQ
  , GT
  , LT
  , OProxy(OProxy)
  , kind Ordering
  )
import Type.Data.Ordering (reflectOrdering) as Standard
import Type.Proxy (Proxy(Proxy))

class
  Generic (f s) rep
  <= GenericOProxying (rep :: Type) (f :: Ordering -> Type) (s :: Ordering)
  where
  genericOProxy :: Proxy rep ->  f s

instance genericOProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericOProxying (Constructor proxyName NoArguments) f s
  where
  genericOProxy _ = to (Constructor NoArguments)

class OProxying (f :: Ordering -> Type) (s :: Ordering) where
  oProxy :: f s

instance oProxyingOProxy :: OProxying OProxy s where
  oProxy = OProxy

else instance oProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => OProxying f s
  where
  oProxy = genericOProxy (Proxy :: Proxy (Constructor proxyName NoArguments))

reflectOrdering
  :: forall f o
   . OProxying f o
  => IsOrdering o
  => (f o)
  -> Ordering
reflectOrdering _ = Standard.reflectOrdering (OProxy :: OProxy o)

reifyOrdering
  :: forall r
   . Ordering ->
  (forall o f. OProxying f o => IsOrdering o => f o -> r)
  -> r
reifyOrdering EQ fn = fn (OProxy :: OProxy EQ)
reifyOrdering GT fn = fn (OProxy :: OProxy GT)
reifyOrdering LT fn = fn (OProxy :: OProxy LT)
