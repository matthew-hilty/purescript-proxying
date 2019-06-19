module Type.Proxying.Boolean
  ( class BProxying
  , class GenericBProxying
  , bProxy
  , genericBProxy
  , reflectBoolean
  , reifyBoolean
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Data.Boolean
  ( class IsBoolean
  , BProxy(BProxy)
  , False
  , True
  , kind Boolean
  )
import Type.Data.Boolean (reflectBoolean) as Standard
import Type.Proxy (Proxy(Proxy))

class
  Generic (f b) rep
  <= GenericBProxying (rep :: Type) (f :: Boolean -> Type) (b :: Boolean)
  where
  genericBProxy :: Proxy rep ->  f b

instance genericBProxyingConstructor
  :: Generic (f b) (Constructor proxyName NoArguments)
  => GenericBProxying (Constructor proxyName NoArguments) f b
  where
  genericBProxy _ = to (Constructor NoArguments)

class BProxying (f :: Boolean -> Type) (b :: Boolean) where
  bProxy :: f b

instance bProxyingBProxy :: BProxying BProxy b where
  bProxy = BProxy

else instance bProxyingGeneric
  :: Generic (f b) (Constructor proxyName NoArguments)
  => BProxying f b
  where
  bProxy = genericBProxy (Proxy :: Proxy (Constructor proxyName NoArguments))

reflectBoolean :: forall f b. BProxying f b => IsBoolean b => (f b) -> Boolean
reflectBoolean _ = Standard.reflectBoolean (BProxy :: BProxy b)

reifyBoolean
  :: forall r
   . Boolean ->
  (forall b f. BProxying f b => IsBoolean b => f b -> r)
  -> r
reifyBoolean true fn = fn (BProxy :: BProxy True)
reifyBoolean false fn = fn (BProxy :: BProxy False)
