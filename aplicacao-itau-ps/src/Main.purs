module Main where

import Prelude

import Data.Array (Array)
import Effect (Effect)
import Effect.Console (log)
import Halogen.Aff as HA
import Halogen.Aff.Util (runHalogenAff)
import Halogen.HTML as HH
import Halogen.HTML.Elements as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import Halogen.Component (Component, component, render)

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
  HE.tr_
    [ HE.td_ [ HH.text transaction.accountOwner ]
    , HE.td_ [ HH.text transaction.transferTo ]
    , HE.td_ [ HH.text transaction.account ]
    , HE.td_ [ HH.text transaction.bank ]
    , HE.td_ [ HH.text $ show transaction.amount ]
    , HE.td_ [ HH.text $ if transaction.isPix then "Yes" else "No" ]
    ]

renderTable :: Array Transaction -> HH.HTML
renderTable txs =
  HE.table_
    [ HE.thead_
        [ HE.tr_
            [ HE.th_ [ HH.text "Proprietario da conta" ]
            , HE.th_ [ HH.text "Transferido para" ]
            , HE.th_ [ HH.text "Conta" ]
            , HE.th_ [ HH.text "Banco" ]
            , HE.th_ [ HH.text "Valor transferido" ]
            , HE.th_ [ HH.text "Status" ]
            ]
        ]
    , HE.tbody_ (map renderTransaction txs)
    ]

ui :: Component HA.Query Unit Unit Void Unit
ui = component
  { initialState: \_ -> unit
  , render: const $ renderTable transactions
  , eval: \_ _ -> pure unit
  }

main :: Effect Unit
main = runHalogenAff do
  body <- HA.awaitBody
  runUI ui unit body
