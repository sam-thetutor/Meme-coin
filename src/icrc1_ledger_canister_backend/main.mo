
import TokenClass "./icrcTokenClass";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor AUTODEPLOY={

  //function to deploy the token canister

  public shared({caller}) func deployToken(_name:Text,_symbol:Text,_transferFee:Nat,_decimals:Nat): async Result.Result<Text,Text>{

//add the cycles to cater for the canister creation
        Cycles.add(1000000000000);
        //create a token instance class with the
    let myToken = await TokenClass.Ledger(
      {
          initial_mints = [];
          minting_account = {
            owner = caller;
            subaccount = null;
          };
          token_name = _name;
          token_symbol = _symbol;
          decimals = _decimals;
          transfer_fee = _transferFee;
        }
      );
    let principalID = Principal.fromActor(myToken);
    //return the canister id of the newly created token
    return #ok(Principal.toText(principalID));
  }
}
  
