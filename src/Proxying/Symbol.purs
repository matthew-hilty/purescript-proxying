module Type.Proxying.Symbol
  ( class GenericSProxying
  , class SProxying
  , genericSProxy
  , reflectSymbol
  , reifySymbol
  , sProxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Data.Symbol (class IsSymbol, SProxy(SProxy))
import Data.Symbol (reflectSymbol) as Standard
import Type.Proxy (Proxy(Proxy))

class
  Generic (f s) rep
  <= GenericSProxying (rep :: Type) (f :: Symbol -> Type) (s :: Symbol)
  where
  genericSProxy :: Proxy rep ->  f s

instance genericSProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericSProxying (Constructor proxyName NoArguments) f s
  where
  genericSProxy _ = to (Constructor NoArguments)

class SProxying (f :: Symbol -> Type) (s :: Symbol) where
  sProxy :: f s

instance sProxyingSProxy :: SProxying SProxy s where
  sProxy = SProxy

else instance sProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => SProxying f s
  where
  sProxy = genericSProxy (Proxy :: Proxy (Constructor proxyName NoArguments))

reflectSymbol :: forall f s. IsSymbol s => SProxying f s => (f s) -> String
reflectSymbol _ = Standard.reflectSymbol (SProxy :: SProxy s)

reifySymbol
  :: forall r
   . String
  -> (forall f s. IsSymbol s => SProxying f s => f s -> r)
  -> r
reifySymbol s fn = coerce fn { reflectSymbol: \_ -> s } SProxy where
  coerce
    :: (forall f s. IsSymbol s => SProxying f s => f s -> r)
    -> { reflectSymbol :: SProxy "" -> String }
    -> SProxy ""
    -> r
  coerce = unsafeCoerce

foreign import unsafeCoerce :: forall a b. a -> b
