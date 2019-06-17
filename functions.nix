with builtins;
let 

  isPrime = import ./isPrime.nix;
  math = import ./math.nix;

in {
  inherit isPrime math;

  rev = xs: foldl' (acc: x: [x] ++ acc) [] xs;
}

/*
nix repl --option allow-unsafe-native-code-during-evaluation true
builtins.exec ["echo" "\"hello\""]
*/
