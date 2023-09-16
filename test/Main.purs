module Test.Main where

import Prelude (Unit, ($))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

import Pustache.Parser (Config(..), parse)

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "Pustache.Parser" do
    describe "parse \"Hello, {{world}}\"" do
      it "returns \"Hello, world\" string" do
        parse "Hello, {{name}}" [DoubleBrace { parameter: "name", value: "world" }] `shouldEqual` "Hello, world"
