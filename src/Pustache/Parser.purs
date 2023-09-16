module Pustache.Parser where

import Prelude ((<>))

import Data.Array (foldl)
import Data.String.Regex as Regex
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex.Flags (RegexFlags(..))

regexFlag :: RegexFlags
regexFlag = RegexFlags
  { dotAll: false
  , global: true
  , ignoreCase: true
  , multiline: true
  , sticky: false
  , unicode: true
  }

type Template = String

type Configs = Array Config

data Config
  = DoubleBrace
      { parameter :: String
      , value :: String
      }

parse' :: Template -> Config -> String
parse' template (DoubleBrace { parameter, value }) =
  let pattern = "\\{\\{" <> parameter <> "\\}\\}" in
  Regex.replace
    (unsafeRegex pattern regexFlag)
    value
    template
 
parse :: Template -> Configs -> String
parse = foldl parse'
