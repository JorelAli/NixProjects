#!/run/current-system/sw/bin/nix-instantiate --eval 
let isPrime = import ./isPrime.nix;
in {x ? 2, silent ? true}: 
  if silent 
  then isPrime x
  else builtins.trace "Checking if ${toString x} is prime" (isPrime x)
