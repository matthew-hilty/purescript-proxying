module Type.Proxying.Type3
  ( class GenericT3Proxying
  , class T3Proxying
  , genericT3Proxy
  , t3Proxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Proxy (Proxy(Proxy), Proxy3(Proxy3))

class
  Generic (f s) rep
  <= GenericT3Proxying
      (rep :: Type)
      (f :: (Type -> Type -> Type) -> Type)
      (s :: Type -> Type -> Type)
  where
  genericT3Proxy :: Proxy rep ->  f s

instance genericT3ProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericT3Proxying (Constructor proxyName NoArguments) f s
  where
  genericT3Proxy _ = to (Constructor NoArguments)

class T3Proxying
  (f :: (Type -> Type -> Type) -> Type)
  (a :: Type -> Type -> Type)
  where
  t3Proxy :: f a

instance t3ProxyingProxy3 :: T3Proxying Proxy3 a where
  t3Proxy = Proxy3

else instance t3ProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => T3Proxying f s
  where
  t3Proxy = genericT3Proxy (Proxy :: Proxy (Constructor proxyName NoArguments))
