use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/interval
use cardano/address.{Address}
use cardano/transaction.{
  Datum, InlineDatum, Output, OutputReference, Transaction,
}

/// shorthand notation for custom types
/// the full version would have the explicit Data Constructor like
/// type Datum { Datum {...fields are the same...} }
pub type CFdatum {
  campaign_id: Int,
  title: ByteArray,
  goal: Int,
  creator: VerificationKeyHash,
  backer: VerificationKeyHash,
  amount: Int,
  deadline: Int,
  current_funds: Int,
}

/// Actions Enumerator
///  0 -> Cancel Campaign
///  1 -> Support Campaign
///  2 -> 
///
pub type Action =
  Int

pub type CFredeemer {
  campaign_id: Int,
  action: Action,
  amount: Int,
  backer: VerificationKeyHash,
}

validator manage_campaign {
  spend(
    datum: Option<CFdatum>,
    redeemer: CFredeemer,
    utxo: OutputReference,
    transaction: Transaction,
  ) {
    expect Some(datum) = datum

    when redeemer.action is {
      0 ->
        cancel_campaign(
          datum,
          redeemer.campaign_id,
          transaction.extra_signatories,
        )

      1 -> support_campaign(datum, redeemer.campaign_id, utxo, transaction)

      2 -> claims(datum, redeemer.campaign_id, transaction)
      _ -> fail
    }
  }

  else(_) {
    fail
  }
}

/// Cancellation conditions
///  Datum.campaignId == Redeemer.campaignId
///  Datum.creator => Authorize transaction by signing it.
///  Datum.current_funds == 0
///  Datum.amount == 0
///
fn cancel_campaign(
  datum: CFdatum,
  campaign_id: Int,
  signatories: List<VerificationKeyHash>,
) -> Bool {
  datum.campaign_id == campaign_id && datum.current_funds == 0 && datum.amount == 0 && datum.backer == "" && must_be_signed_by(
    datum.creator,
    signatories,
  )
}

//  Dataum.creator == input.datum.creator
// output.address == input.address (input (datum.campign_id))
/// Update conditions
///    Datum.campaignId == Redeemer.campaignId
///    Datum.backer => Authorize his support by signing the transaction.
///
fn support_campaign(
  datum: CFdatum,
  campaign_id: Int,
  utxo: OutputReference,
  tx: Transaction,
) -> Bool {
  expect Some(input_utxo) = transaction.find_input(tx.inputs, utxo)
  let input_datum = input_utxo.output.datum
  and {
    (datum.campaign_id == campaign_id)?,
    must_be_signed_by(datum.backer, tx.extra_signatories)?,
    datum_creator_match(datum, input_datum),
    must_be_sent_to_script(input_utxo.output.address, tx.outputs),
  }
}

/// Claims conditions
///   Datum.campaignId == Redeemer.campaignId
///   Datum.current_funds >= Datum.goal
///   Datum.creator => Authorize transaction by signingn it.
///
fn claims(datum: CFdatum, campaign_id: Int, tx: Transaction) -> Bool {
  (datum.campaign_id == campaign_id)? && (
    (datum.current_funds >= datum.goal)? || interval.is_entirely_after(
      tx.validity_range,
      datum.deadline,
    )?
  ) && must_be_signed_by(
    // deadline must be after
    datum.creator,
    tx.extra_signatories,
  )
}

fn must_be_signed_by(
  signer: VerificationKeyHash,
  signatories: List<VerificationKeyHash>,
) -> Bool {
  // The verificationKeyHash is the hash of the verification key of the signature
  list.has(signatories, signer)
}

// This contract is like swiss cheese, full of holes.

fn must_be_sent_to_script(address: Address, outputs: List<Output>) -> Bool {
  let counter =
    list.count(outputs, fn(output) -> Bool { output.address == address })
  counter == 1
}

// fn must_happen_after(range: ValidityRange, deadline: Int) {
//   when range.lower_bound.bound_type is {
//     Finite(tx_latest_time) -> (lock_expiration_time <= tx_latest_time)?
//     _ -> False
//   }
// }

// fn complete_datum(
//   input_datum: CFdatum,
//   datums: Dict<DataHash, Data>,
// ) -> (DataHash, Data) {
//   expect Some(data_hash) = dict.find(datums, input_datum)

//   let data_hash: DataHash = data_hash
//   let data: Data = input_datum

//   (data_hash, data)
// }

fn datum_creator_match(datum: CFdatum, tx_datum: Datum) -> Bool {
  when tx_datum is {
    // InlineDatum(datum_data) ->
    //   // when
    //   list.has(
    //     pairs.values(un_constr_data(datum_data)),
    //     fn(value) -> Bool { value == datum.creator },
    //   )
    // // is {
    // //   Some(_) -> True
    // //   _ -> False
    // // }
    // // list.has(un_constr_data(datum_data).2nd, datum.creator)
    InlineDatum(datum_data) -> {
      // let Pair(key, datalist) = un_constr_data(datum_data)
      expect input_datum: CFdatum = datum_data
      input_datum.creator == datum.creator
    }
    _ -> False
  }
}
