module Type.Proxying.TypeExpr
  ( class GenericTEProxying
  , class TEProxying
  , genericTEProxy
  , proxyEval
  , teProxy
  ) where

import Data.Generic.Rep
  ( class Generic
  , Constructor(Constructor)
  , NoArguments(NoArguments)
  , to
  )
import Type.Eval (class Eval, TEProxy(TEProxy), kind TypeExpr)
import Type.Proxy (Proxy(Proxy))

class
  Generic (f s) rep
  <= GenericTEProxying
      (rep :: Type)
      (f :: TypeExpr -> Type)
      (s :: TypeExpr)
  where
  genericTEProxy :: Proxy rep ->  f s

instance genericTEProxyingConstructor
  :: Generic (f s) (Constructor proxyName NoArguments)
  => GenericTEProxying (Constructor proxyName NoArguments) f s
  where
  genericTEProxy _ = to (Constructor NoArguments)

class TEProxying (f :: TypeExpr -> Type) (e :: TypeExpr) where
  teProxy :: f e

instance teProxyingTEProxy :: TEProxying TEProxy e where
  teProxy = TEProxy

else instance teProxyingGeneric
  :: Generic (f s) (Constructor proxyName NoArguments)
  => TEProxying f s
  where
  teProxy = genericTEProxy (Proxy :: Proxy (Constructor proxyName NoArguments))

proxyEval :: forall e f t. Eval e t => TEProxying f e => f e -> Proxy t
proxyEval _ = Proxy
