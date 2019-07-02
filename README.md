# NixProject
A bunch of little projects written in Nix

## List of projects

* `b.nix` - "Reading an input from the console". Depends on the `b` executable and the following environment:
  ```
  nix repl --option allow-unsafe-native-code-during-evaluation
  ```
* `binary.nix` - Converts decimals to binary and binary to decimals
* `cipher.nix` - An implementation of a basic letter to number converter
* `complex.nix` - An implementation of complex numbers in Nix
* `coolList.nix` - An implementation of a recursive list in Nix and learning that you can use `foldl'` on lists (instead of just numbers)
* `functions.nix` - A bunch of sneaky nix tricks and a reverse list function
* `functors.nix` - An example of using the `__functor` function in Nix's sets
* `isPrime.nix` - Checks if a number is prime
* `levenshtein.nix` - Calculates the Levenshtein distance of two strings. Complexity is garbage and can totally crash if the strings are very large in length.
* `lookupTable.nix` - A lookup table written in Nix, using the `__functor` ... function
* `math.nix` - Various math functions, including:
  * `abs` Absolute function
  * `ceil` and `floor` functions
  * Constants `pi` and `e`
  * `min` and `max` functions
  * `pow` and `sqrt` functions to raise numbers to a power and find a number's square root
  * `mod` function, to find the modulo of a number
  * `ln`, the natural logarithm
  * Various "random number" generators
* `nixoptions.nix` - A failed attempt to list all options for NixOS. Instead, use `nix repl '<nixpkgs/nixos>` and type `config.`.
* `prime.nix` - An executable Nix file which outputs whether a number is prime or not. To execute this file, use the `./prime.nix` command. To pass functions to this, you must use the `--arg` option with parameter name `x`, followed by a number. For example:
  ```
  ./prime.nix --arg x 1423
  ```
* `primeSieve.nix` - A prime sieve
* `satSolver.nix` - A SAT solver
* `streams.nix` - Lists of infinite length in Nix as well as some operations which can be performed on them
* `svg.nix` - Because I felt like writing an EDSL like thing for SVGs in Nix
