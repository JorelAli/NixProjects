# NixProject
A bunch of little projects written in Nix

## List of projects

* `cipher.nix` - An implementation of a basic letter to number converter
* `complex.nix` - An implementation of complex numbers in Nix
* `coolList.nix` - An implementation of a recursive list in Nix and learning that you can use `foldl'` on lists (instead of just numbers)
* `functions.nix` - A bunch of sneaky nix tricks and a reverse list function
* `functors.nix` - An example of using the `__functor` function in Nix's sets
* `isPrime.nix` - Checks if a number is prime
* `math.nix` - Various math functions, including:
  * `abs` Absolute function
  * `ceil` and `floor` functions
  * Constants `pi` and `e`
  * `min` and `max` functions
  * `pow` and `sqrt` functions to raise numbers to a power and find a number's square root
  * `mod` function, to find the modulo of a number
  * `ln`, the natural logarithm
  * Various "random number" generators
* `prime.nix` - An executable Nix file which outputs whether a number is prime or not
  To execute this file, use the `./prime.nix` command. To pass functions to this, you must use the `--arg` option with parameter name `x`, followed by a number. For example:
  ```
  ./prime.nix --arg x 1423
  ```
* `primeSieve.nix` - A prime sieve
* `satSolver.nix` - A SAT solver
* `streams.nix` - Lists of infinite length in Nix as well as some operations which can be performed on them
* `svg.nix` - Because I felt like writing an EDSL for SVGs in Nix
