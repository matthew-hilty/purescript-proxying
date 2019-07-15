# purescript-proxying

Typeclass interfaces for generalizing proxying encapsulations of kind `Type`

## Installation

```
bower install purescript-proxying
```

A common practice in PureScript is the proxying of a type of kind other than `Type`. Examples of such proxies include `SProxy` in the 'prelude' package and `BProxy` in the 'typelevel-prelude' package.

The suite of proxies in PureScript development has become standardized. However, because the choice of `Type`-inducing wrapper for any `RowList`, `Symbol`, etc., is semantically inconsequential (its only responsibility is to induce a change of kind), a possibility of "proxy proliferation" exists. An example can be found in the earlier 3.0.0 versions of 'prelude' and 'typelevel-prelude'. Both declare an `RLProxy`, and this duplication of proxies has been a potential source of dependency-management difficulty.

The `RLProxy` variance has since been addressed by 'typelevel-prelude' in version 4.0.0. However, some PureScript projects still rely on earlier versions of 'typelevel-prelude'. Moreover, little prevents independent projects from defying convention; unnecessarily bespoke copies of standard proxies require but a single line of code.

Although proxy impedance isn't a pressing or common problem, edge-case irritants and third-party-code incompatibilities may yet lurk. This 'purescript-proxying' package might be able to assist with some of those infelicities by allowing libraries to support any registered or generic proxying implementation, not just standard implementations. It doesn't fully alleviate dependency problems, but it resolves some. And as a bonus, use of 'purescript-proxying' promotes code targeting property-based abstractions rather than concrete types -- a general best-practice in software development.
