module Type.Proxying.Type2
  ( class GenericT2Proxying
  , class T2Proxying
  , genericT2Proxy
  , t2Proxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Proxy (Proxy(Proxy), Proxy2(Proxy2))

class
  Generic (f s) rep
  <= GenericT2Proxying
      (rep :: Type)
      (f :: (Type -> Type) -> Type)
      (s :: Type -> Type)
  where
  genericT2Proxy :: Proxy rep ->  f s

instance genericT2ProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericT2Proxying (Constructor proxyName NoArguments) f s
  where
  genericT2Proxy _ = to (Constructor NoArguments)

class T2Proxying (f :: (Type -> Type) -> Type) (a :: Type -> Type) where
  t2Proxy :: f a

instance t2ProxyingT1Proxy :: T2Proxying Proxy2 a where
  t2Proxy = Proxy2

else instance t2ProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => T2Proxying f s
  where
  t2Proxy = genericT2Proxy (Proxy :: Proxy (Constructor proxyName NoArguments))
