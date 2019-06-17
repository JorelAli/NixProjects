with builtins; with import ./math.nix; rec {

  revNum = x: let reversed = revStr (toString x); in
    if substring 0 1 reversed == "0" then false else toInt reversed;

  revStr = str: revStr' str "";

  revStr' = str: revS: 
    if str == "" then revS else
      let newStr = substring 0 ((stringLength str) - 1) str;
          newRev = revS + substring ((stringLength str) - 1) (stringLength str) str;
          in revStr' newStr newRev;

  toInt = str:
    let may_be_int = fromJSON str; in
    if isInt may_be_int
      then may_be_int
      else throw "Could not convert ${str} to int."; 

  strToCharList = str: strToCharList' str [];

  strToCharList' = str: acc: 
    if str == "" then acc else
    strToCharList' (substring 1 (stringLength str) str) (acc ++ [(substring 0 1 str)]);
  
}
