script_utxo="9819324cebdae3a94eb2ef746485e17fdfa837446d6975956b831283cde6a4dd#0"
script_address=$(cat ../compiled/crowdfunding.addr) 
user_utxo="dd46747e40d4da9edc77c7531eb84b8dc7729a84d8d0a58c1c46f4acb4944819#0"
output="7300000000"
saverPKH=$(cat $HOME/Dev/Wallets/Adr08.pkh)
collateralPKH=$(cat $HOME/Dev/Wallets/Adr07.pkh)
collateral="4cbf990857530696a12b0062546a4b123ad0bef21c67562e32d03e3288bdcd7b#0"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $script_utxo \
  --tx-in-script-file ../compiled/crowdfunding.uplc \
  --tx-in-datum-file ../values/CFdatun.json \
  --tx-in-redeemer-file ../values/CFredeener.json \
  --tx-in $user_utxo \
  --required-signer-hash $saverPKH \
  --tx-in-collateral $collateral \
  --tx-out $script_address+$output \
  --tx-out-datum-hash-file ../values/CFdatun.json \
  --change-address $nami3 \
  --out-file supportCampaign.unsigned

cardano-cli conway transaction sign \
    --tx-body-file supportCampaign.unsigned \
    --signing-key-file $HOME/Dev/Wallets/Adr08.skey \
    --signing-key-file $HOME/Dev/Wallets/Adr07.skey \
    $PREVIEW \
    --out-file supportCampaign.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file supportCampaign.signed