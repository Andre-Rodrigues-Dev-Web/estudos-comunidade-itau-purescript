module Main where

import Prelude

import Data.Array (singleton)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..))
import Data.Generic.Rep (class Generic)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Effect (Effect)
import Effect.Console as Console

type Transaction =
  { accountOwner :: String
  , transferTo :: String
  , account :: String
  , bank :: String
  , amount :: Number
  , isPix :: Boolean
  }

transactions :: Array Transaction
transactions =
  [ { accountOwner: "Alice", transferTo: "Bob", account: "12345-6", bank: "Itaú", amount: 100.0, isPix: true }
  , { accountOwner: "Charlie", transferTo: "Dave", account: "23456-7", bank: "Itaú", amount: 250.5, isPix: false }
  , { accountOwner: "Eve", transferTo: "Frank", account: "34567-8", bank: "Itaú", amount: 75.25, isPix: true }
  ]

renderTransaction :: Transaction -> HH.HTML
renderTransaction transaction =
  HH.tr_
    [ HH.td_ [ HH.text transaction.accountOwner ]
    , HH.td_ [ HH.text transaction.transferTo ]
    , HH.td_ [ HH.text transaction.account ]
    , HH.td_ [ HH.text transaction.bank ]
    , HH.td_ [ HH.text $ show transaction.amount ]
    , HH.td_ [ HH.text $ if transaction.isPix then "Yes" else "No" ]
    ]

renderTable :: Array Transaction -> HH.HTML
renderTable txs =
  HH.table_
    [ HH.thead_
        [ HH.tr_
            [ HH.th_ [ HH.text "Proprietario da conta" ]
            , HH.th_ [ HH.text "Transferido para" ]
            , HH.th_ [ HH.text "Conta" ]
            , HH.th_ [ HH.text "Banco" ]
            , HH.th_ [ HH.text "Valor transferido" ]
            , HH.th_ [ HH.text "Status" ]
            ]
        ]
    , HH.tbody_ (map renderTransaction txs)
    ]

main :: Effect Unit
main = do
  let table = renderTable transactions
  HH.renderToBody table
