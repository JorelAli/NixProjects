with builtins;
let
  a=2;
in rec {

  decompose = x: decompose' x 0;
  
  decompose' = x: acc: 
    if x == 1 then acc
    else acc + (decompose' (x - 1) acc);
    
    }
