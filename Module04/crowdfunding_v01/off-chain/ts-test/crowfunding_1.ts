// import { Lucid, Blockfrost, SpendingValidator, fromHex, toHex, Credential, credentialToAddress } from "npm:@lucid-evolution/lucid";
import {Address, Credential, Constr, Data, LucidEvolution, MintingPolicy,  TxSignBuilder, applyDoubleCborEncoding, applyParamsToScript, fromText, mintingPolicyToId} from "npm:@lucid-evolution/lucid";

export interface contractJSON {
    "type": string;
    "description": string;
    "cborHex": string;
}
export async function writeJson(filePath: string, o: any) {
  await Deno.writeTextFile(filePath, JSON.stringify(o, null, 2));
}

const validator_aiken = applyDoubleCborEncoding("59024c01010032323232323232223225333005323232323253323300b3001300c3754004264a6660186004601a6ea80104c8c8c8c8c8c8c8c94ccc05cc0680084c94ccc054c8cc004004dd6180d980c1baa01022533301a00114a0264a66603066ebcc010c068dd5180e80100b8a51133003003001301d00115332330163232533301b301e00213253330193004375a6036004266e3c0040585281bae301900116301c001325333017300230183754002297adef6c6013756603860326ea8004c8cc004004dd5980e180e980e980e980e980c9baa01122533301b00114c103d87a8000132323232533301c337220220042a66603866e3c0440084cdd2a4000660406e980052f5c02980103d87a80001330060060033756603a0066eb8c06c008c07c008c0740044c94ccc05cc0340044c8c8cc004004dd6180f180f980f980f980f980f980f980f980f980d9baa01322533301d00114a0264a66603666e3cdd718100010020a511330030030013020001375c6038603a603a60326ea803c54ccc05cc0080044c8cc88c94ccc06cc018c070dd5000899b89002375a6040603a6ea80045281803180e1baa3003301c3754004603a603c603c603c603c603c603c603c60346ea8048dd69800980d1baa0102301d301e00114a06eb4c008c060dd50071b87480085280a502301a00116375a603000260300046eb8c058004c058008dd6980a000980a0011bad3012001300e37540082c6eb8c040c034dd50011b874800058c038c03c008c034004c034008c02c004c01cdd50008a4c26cac6eb80055cd2ab9d5573caae7d5d02ba157441")

// console.log("Aiken validator: ");
// console.log(validator_aiken);
// console.log("-----------------");

const validatorFile: string = Deno.args[0];
const params_validtorFile: string = Deno.args[1];

async function getValidator(filePath: string) {
        return JSON.parse(await Deno.readTextFile(filePath));
}

const validator: any = await getValidator(validatorFile);

// console.log(validatorFile);
// console.log(validator);

// PARAMETERS VALUES - MUST UPDATED TO CORRECT VALUES
//
const utxoRef: any = new Constr(0, ["946500cb21ac2f0e1645e11632f53cef21b3e28b3993e7ea910cfd96fbc7e424", BigInt(0)]);
const tokenName: string = ("576f575f4e46542dcebb2df09f90a6f09f988d");



const params_validator = applyParamsToScript(validator.cborHex, [utxoRef, tokenName]);
const params_aiken_validator = applyParamsToScript(validator_aiken, [utxoRef, tokenName]);

// console.log("Aiken copy pasted validator parametrized: ");
// console.log(params_aiken_validator);

const params_ea_nft_val: contractJSON = {
    type: "PlutusScriptV3",
    description: "Parametrized Aiken validator.",
    cborHex: params_validator
}

// console.log(params_ea_nft_val);

writeJson(params_validtorFile, params_ea_nft_val);

console.log("PARAMETRIZED VALIDATOR CREATED!");


// import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";
// import {Blockfrost, Data, Lucid, Validator, validatorToAddress,Credential} from "npm:@lucid-evolution/lucid";
// import {credentialToAddress} from "npm:@lucid-evolution/utils";
// import test01_signingKey from "../../../Wallets/Adr11skey.json" with {type: 'json'};
// import * from "./settings.ts";



// const lucid = await Lucid(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_PROJECT_ID"),),netid);

// const paymentCredential: Credential = {
//      type: "Key",
//      hash: "2070f8488dd696b78a5f23e38d273550e43660526c4b19cba733b488"  //taken from cardano-cli generated verification key hash
//  };

// const stakeCredential: Credential = {
//        type: "Key",
//        hash: "8662fe85a22159022d71aebcf4342bcafaa6ede0df2e486a4e751e8e" // taken from cardano-cli generated stake verification key hash
//    };
// const address11 = await credentialToAddress(netid,paymentCredential, stakeCredential);
// await Deno.writeTextFile("our.addr", address11);

