use aiken/collection/list.{has}
use aiken/crypto.{VerificationKeyHash}
use aiken/interval.{Finite, Interval}
use cardano/transaction.{Transaction}

pub type VestingDatum {
  beneficiary: VerificationKeyHash,
  deadline: Int,
}

validator vesting {
  spend(datum: Option<VestingDatum>, _redeemer, _oref, tx: Transaction) {
    expect Some(datum) = datum
    must_happen_after(tx.validity_range, datum.deadline) && must_be_signed_by(
      tx.extra_signatories,
      datum.beneficiary,
    )
  }

  else(_) {
    fail
  }
}

fn must_be_signed_by(
  extra_signatories: List<VerificationKeyHash>,
  beneficiary: VerificationKeyHash,
) {
  has(extra_signatories, beneficiary)
}

fn must_happen_after(range: Interval<Int>, deadline: Int) {
  when range.lower_bound.bound_type is {
    Finite(tx_time) -> (tx_time > deadline)?
    _ -> False
  }
}

test vest() {
  let vesting_datum = VestingDatum { beneficiary: "PKH", deadline: 10 }

  let tx =
    Transaction {
      ..transaction.placeholder,
      extra_signatories: ["PKH"],
      validity_range: interval.after(11),
    }
  vesting.spend(Some(vesting_datum), "0", "oref", tx) == True
}
