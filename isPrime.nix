inputNum:

let
  
  mod = (import ./math.nix).mod;
  myList = num: builtins.genList (x: x + 2) (num - 2);
  primeMap = num: list: builtins.map (x: mod num x) list;

in

  if inputNum < 2 then false
  else !builtins.any (x: x == 0) (primeMap inputNum (myList inputNum))
