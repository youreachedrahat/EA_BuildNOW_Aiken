use aiken/collection/list.{count, has}
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{PolicyId, from_asset, policies}
use cardano/transaction.{Input, Transaction}

validator r_minter(nft: PolicyId, owner: VerificationKeyHash) {
  mint(redeemer, _policy_id: PolicyId, tx: Transaction) {
    must_have_nft(tx.inputs, nft) && must_be_signed_by(
      tx.extra_signatories,
      owner,
    )
  }

  else(_) {
    fail
  }
}

fn must_have_nft(inputs: List<Input>, nft: PolicyId) {
  let counter =
    count(inputs, fn(input) -> Bool { has(policies(input.output.value), nft) })
  counter == 1
}

fn must_be_signed_by(
  signatories: List<VerificationKeyHash>,
  owner: VerificationKeyHash,
) {
  has(signatories, owner)
}

test minter() {
  False
  // let assetx = from_asset("pppp", "r", 10)
  // let tx =
  // Transaction {
  //   ..transaction.placeholder,
  //   extra_signatories: ["PKH"],
  //   inputs.output.value: assetx,
  // }
  // let tx = Transaction { ..transaction.placeholder, extra_signatories: ["PKH"] }
  // r_minter.mint("pppp", "PKH") == False
}
