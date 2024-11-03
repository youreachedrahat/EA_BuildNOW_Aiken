use aiken/interval
use cardano/address.{from_verification_key}
use cardano/assets.{from_lovelace}
use cardano/transaction.{
  InlineDatum, Input, Output, OutputReference, Transaction,
}
use cf.{CFdatum, CFredeemer}

test cf_cancel_campaign_v01() {
  let utxo_ref = OutputReference("", 0)
  let datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign ",
      goal: 100000000,
      creator: "AFDA",
      backer: "",
      amount: 0,
      deadline: 100,
      current_funds: 0,
    }
  let wrong_datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign ",
      goal: 0,
      creator: "",
      backer: "AFDB",
      amount: 10_000_000,
      deadline: 0,
      current_funds: 0,
    }
  let redeemer = CFredeemer { campaign_id: 1, action: 0, amount: 0, backer: "" }
  let tx_info =
    Transaction { ..transaction.placeholder, extra_signatories: ["AFDA"] }
  and {
    cf.manage_campaign.spend(Some(datum), redeemer, utxo_ref, tx_info),
    cf.manage_campaign.spend(Some(wrong_datum), redeemer, utxo_ref, tx_info) == False,
  }
}

test cf_update_campaign_v01() {
  let cfdatum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign",
      goal: 100000000,
      creator: "AFDA",
      backer: "AFDB",
      amount: 0,
      deadline: 100,
      current_funds: 0,
    }
  let utxo_ref = OutputReference("", 0)

  let addr =
    from_verification_key(
      "#5820f695aa0d03c039fc293803da371873cb6e757d3f6ac113f28647c97fbc25bf0d",
    )
  let output =
    Output {
      address: addr,
      value: from_lovelace(10000000),
      datum: InlineDatum(cfdatum),
      reference_script: None,
    }
  let input = Input { output_reference: utxo_ref, output }
  let tx_info =
    Transaction {
      ..transaction.placeholder,
      extra_signatories: ["AFDB"],
      inputs: [input],
      outputs: [output],
    }
  let redeemer = CFredeemer { campaign_id: 1, action: 1, amount: 0, backer: "" }
  cf.manage_campaign.spend(Some(cfdatum), redeemer, utxo_ref, tx_info) == True
}

test cf_claim_campaign_v01() {
  let utxo_ref = OutputReference("", 0)
  let tx_info =
    Transaction {
      ..transaction.placeholder,
      extra_signatories: ["AFDA"],
      validity_range: interval.entirely_after(1001),
    }
  let datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign",
      goal: 100000000,
      creator: "AFDA",
      backer: "AFDB",
      amount: 0,
      deadline: 100,
      current_funds: 1000000,
    }
  let redeemer = CFredeemer { campaign_id: 1, action: 2, amount: 0, backer: "" }
  cf.manage_campaign.spend(Some(datum), redeemer, utxo_ref, tx_info) == True
}
// test supportx() {
//   let utxo_ref = OutputReference("", 0)
//   let utxo_ref2 = OutputReference("", 2)
//   let cfdatum =
//     CFdatum {
//       campaign_id: 1,
//       title: "Demo Campaign",
//       goal: 100000000,
//       creator: "AFDA",
//       backer: "AFDB",
//       amount: 0,
//       deadline: 100,
//       current_funds: 0,
//     }

//   let cfdatum2 =
//     CFdatum {
//       campaign_id: 2,
//       title: "Demo Campaign",
//       goal: 100000000,
//       creator: "AFDAA",
//       backer: "AFDB",
//       amount: 0,
//       deadline: 100,
//       current_funds: 0,
//     }

//   let addr =
//     from_verification_key(
//       "#5820f695aa0d03c039fc293803da371873cb6e757d3f6ac113f28647c97fbc25bf0d",
//     )
//   let input_output =
//     Output {
//       address: addr,
//       value: from_lovelace(10000000),
//       datum: InlineDatum(cfdatum),
//       reference_script: None,
//     }
//   let input = Input { output_reference: utxo_ref, output: input_output }
//   let input2 = Input { output_reference: utxo_ref2, output: input_output }
//   let tx_output =
//     Output {
//       address: addr,
//       value: from_lovelace(100000000),
//       datum: InlineDatum(cfdatum),
//       reference_script: None,
//     }
//   let tx_info =
//     Transaction {
//       ..transaction.placeholder,
//       extra_signatories: ["AFDB"],
//       inputs: [input],
//       outputs: [tx_output],
//     }

//   support_campaign(cfdatum, 1, utxo_ref, tx_info) == True
// }

// fn support_campaign(
//   datum: CFdatum,
//   campaign_id: Int,
//   utxo: OutputReference,
//   tx: Transaction,
// ) -> Bool {
//   expect Some(input_utxo) = transaction.find_input(tx.inputs, utxo)
//   must_be_sent_to_script(input_utxo.output.address, tx.outputs)
// }

// fn must_be_sent_to_script(address: Address, outputs: List<Output>) -> Bool {
//   let counter =
//     list.count(outputs, fn(output) -> Bool { output.address == address })
//   counter == 1
// }
