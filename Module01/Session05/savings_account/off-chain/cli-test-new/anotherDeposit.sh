script_utxo="a3c4da1c6edd7dba0881686c761bb3b8a20b04cb6695f1eb4991913dbdfdbb89#0"
script_address=$(cat ./savings.addr) 
user_utxo="a3c4da1c6edd7dba0881686c761bb3b8a20b04cb6695f1eb4991913dbdfdbb89#1"
output="120000000"
saverPKH="9aa0451c660d1fe0650d9562d892f9d6effee50bec3c528355118673"
# collateralPKH=$(cat $HOME/Dev/Wallets/Adr07.pkh)
collateral="a3c4da1c6edd7dba0881686c761bb3b8a20b04cb6695f1eb4991913dbdfdbb89#1"
changeAddress="addr_test1qzd2q3guvcx3lcr9pk2k9kyjl8twllh9p0krc55r25gcvu7rasj76jfcz9urqwjks9tjvau2jur8cjmr8typ6lgm2t5sjjp3fe"
PREVIEW="--testnet-magic 2"


cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $script_utxo \
  --tx-in-script-file ./value.uplc \
  --tx-in-datum-file ../values/saver.json \
  --tx-in-redeemer-file ../values/value1.json \
  --tx-in $user_utxo \
  --required-signer-hash $saverPKH \
  --tx-in-collateral $collateral \
  --tx-out $script_address+$output \
  --tx-out-datum-hash-file ../values/saver.json \
  --change-address $changeAddress \
  --out-file another_deposit.unsigned

cardano-cli conway transaction sign \
    --tx-body-file another_deposit.unsigned \
    --signing-key-file /home/ubuntu/EA_BuildNOW_Aiken/wallet/bob/bob_payment.skey \
    $PREVIEW \
    --out-file another_deposit.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file another_deposit.signed