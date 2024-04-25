
import TokenClass "./icrcTokenClass";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor AUTODEPLOY={

  //function to deploy the token canister

  public shared({caller}) func deployToken(_name:Text,_symbol:Text,_transferFee:Nat): async Result.Result<Text,Text>{

        Cycles.add(1000000000000);
    let myToken = await TokenClass.Ledger(
      {
          initial_mints = [];
          minting_account = {
            owner = caller;
            subaccount = null;
          };
          token_name = _name;
          token_symbol = _symbol;
          decimals = 8;
          transfer_fee = _transferFee;
        }
      
      );
    let principalID = Principal.fromActor(myToken);
    return #ok(Principal.toText(principalID));
  }


}
  
