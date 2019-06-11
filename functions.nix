with builtins;
let 

  isPrime = import ./isPrime.nix;
  math = import ./math.nix;

in {
  inherit isPrime math;

  rev = xs: foldl' (acc: x: [x] ++ acc) [] xs;
}

/*
In other news, have you ANY idea how insane 
  nix repl --option allow-unsafe-native-code-during-evaluation true
is? It lets you use builtins.exec!

Example:

builtins.exec ["echo" "\"hello\""]

In more other news, this:
nix repl --option allow-unsafe-native-code-during-evaluation true
*/
