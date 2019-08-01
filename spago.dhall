{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
, name =
    "proxying"
, dependencies =
    [ "console"
    , "effect"
    , "generics-rep"
    , "prelude"
    , "test-unit"
    , "typelevel-prelude"
    ]
, packages =
    ./packages.dhall
}
