utxoin="8f4c2835f83e8a15d8dd8d5bdb4ce1f982d9abb2d3c7a07c37b20b44956910a6#0"
address=$(cat ./savings.addr) 
output="100000000"
changeAddress="addr_test1qzd2q3guvcx3lcr9pk2k9kyjl8twllh9p0krc55r25gcvu7rasj76jfcz9urqwjks9tjvau2jur8cjmr8typ6lgm2t5sjjp3fe"
PREVIEW="--testnet-magic 2"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ../values/saver.json \
  --change-address $changeAddress \
  --out-file deposit.unsigned

cardano-cli conway transaction sign \
    --tx-body-file deposit.unsigned \
    --signing-key-file /home/ubuntu/EA_BuildNOW_Aiken/wallet/bob/bob_payment.skey \
    $PREVIEW \
    --out-file deposit.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file deposit.signed