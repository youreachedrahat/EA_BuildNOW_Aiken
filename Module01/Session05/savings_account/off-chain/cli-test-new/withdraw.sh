script_utxo="2674dd9c2167fcbc8f51aafa4ad8e2368845082d0818ad421e1771d5fcbe14c5#0"
script_address=$(cat ./savings.addr) 
output="100000000"
saverPKH="9aa0451c660d1fe0650d9562d892f9d6effee50bec3c528355118673"
# collateralPKH=$(cat $HOME/Dev/Wallets/Adr07.pkh)
collateral="2674dd9c2167fcbc8f51aafa4ad8e2368845082d0818ad421e1771d5fcbe14c5#1"
# Adr08=$(cat $HOME/Dev/Wallets/Adr08.addr)
changeAddress="addr_test1qzd2q3guvcx3lcr9pk2k9kyjl8twllh9p0krc55r25gcvu7rasj76jfcz9urqwjks9tjvau2jur8cjmr8typ6lgm2t5sjjp3fe"
PREVIEW="--testnet-magic 2"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $script_utxo \
  --tx-in-script-file ./value.uplc \
  --tx-in-datum-file ../values/saver.json \
  --tx-in-redeemer-file ../values/value0.json \
    --required-signer-hash $saverPKH \
  --tx-in-collateral $collateral \
  --tx-out $changeAddress+$output \
  --change-address $changeAddress \
  --out-file withdraw.unsigned

cardano-cli conway transaction sign \
    --tx-body-file withdraw.unsigned \
    --signing-key-file /home/ubuntu/EA_BuildNOW_Aiken/wallet/bob/bob_payment.skey \
    $PREVIEW \
    --out-file withdraw.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file withdraw.signed
