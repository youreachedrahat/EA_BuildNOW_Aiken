# Keys and Addresses - First steps using the Cardano blockchain 

## Part 1 Create a new set of keys and address 
Lets create an environment variable as shortcut, you can make it permanent including in the .bashrc file, and restarting terminal.
```bash
    export PREVIEW="--testnet-magic 2"
```

### Note: The Below steps will help you setup an address and fund it with testAda.
If not, execute the following steps to create the address and fund it with test ada.
```bash
    cardano-cli address key-gen \
    --verification-key-file bob_payment.vkey \
    --signing-key-file bob_payment.skey

    cardano-cli stake-address key-gen \
    --verification-key-file bob_stake.vkey \
    --signing-key-file bob_stake.skey

    cardano-cli address build \
    --payment-verification-key-file bob_payment.vkey \
    --stake-verification-key-file bob_stake.vkey \
    --out-file bob.addr \
    $PREVIEW
```

 **Fund the payment address with 1000 Test Ada from the Faucet ([ADA Testnet Faucet](https://docs.cardano.org/cardano-testnet/tools/faucet/))**


Generate necessary keys for the second account
```bash
    cardano-cli address key-gen \
    --verification-key-file alice_payment.vkey \
    --signing-key-file alice_payment.skey

    cardano-cli stake-address key-gen \
    --verification-key-file alice_stake.vkey \
    --signing-key-file alice_stake.skey

    cardano-cli address build \
    --payment-verification-key-file alice_payment.vkey \
    --stake-verification-key-file alice_stake.vkey \
    --out-file alice.addr \
    $PREVIEW
```

And check the UTxO for the payment address 
```bash    
    cardano-cli query utxo --address addr_test1qzd2q3guvcx3lcr9pk2k9kyjl8twllh9p0krc55r25gcvu7rasj76jfcz9urqwjks9tjvau2jur8cjmr8typ6lgm2t5sjjp3fe --testnet-magic 2

                               TxHash                                 TxIx        Amount
    --------------------------------------------------------------------------------------
    7b4956b103d47908318ee92aa0790ff4b36fe7940991f0be350c9085fc4da175     1        100000000000 lovelace + TxOutDatumHashNone
```


cardano-cli query utxo --address $(cat ../../wallet/bob/bob.addr) --testnet-magic 2