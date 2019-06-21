#let inherit (builtins) 
#isInt foldl' genList 
#currentTime toString 
#div head fromJSON split
#add mul; in rec {
  with builtins; rec {
  abs = x: if x < 0 then x * -1 else x;
  
  toInt = str:
      let may_be_int = fromJSON str; in
      if isInt may_be_int
        then may_be_int
        else throw "Could not convert ${str} to int."; 

  
  floatToInt = int: toInt (head (split "\\." (toString int)));

  floor = x: 
    if isInt x 
      then x 
      else 
      let result = floatToInt x;
        in if x > 0 || x - result == 0 
          then result 
          else result - 1;

  ceil = x: 
    if isInt x 
      then x 
      else 
      let result = floatToInt x;
        in if x > 0 
          then result + 1
          else result;


  mod = base: int: base - (int * (div base int));

  pi = 3.141592653589793;
  e = 2.718281828459045;

  # Random. Once.
  pseudoRand = bound: mod (currentTime) bound;
  pseudoRandRange = min: max:
    if min >= max
      then throw "max must be greater than min"
      else pseudoRand ((max - min) + 1) + min;

  max = x: y: if x > y then x else y;
  min = x: y: if x > y then y else x;
  pow = x: power: 
    if isInt power 
      then foldl' mul 1 (genList (val: x) power)
      else throw "Power must be an integer";

  sqrt = x: let
    sqrt' = x: x0: root: iter: let
      num = (pow x0 root) - x;
      denom = x0 * root;
      x1 = x0 - (num / denom);
    in if iter == 0 
      then x0 
      else sqrt' x x1 root (iter - 1); 
  in
    sqrt' x 0.1 2 100;

  ln = x: let 
    ln' = z: precision: genList (k:
    let zs = (z - 1) / (z + 1.0); in
      2 * (1.0 / (2 * k + 1)) * (pow zs (2 * k + 1))
    ) precision; in
    foldl' add 0 (ln' x 1000);

  log = base: x: (ln x) / (ln base);

  log2 = log 2;

  unsafeRand = bound: unsafeRandRange 0 bound;
  unsafeRandRange = min: max: toInt (builtins.readFile 
    (builtins.fetchurl {
      url="https://www.random.org/integers/?num=1&min=${toString min}&max=${toString max}&col=1&base=10&format=plain&rnd=new";
      name="rand";
    }));

  maxValue = 9223372036854775807;
  minValue = (-9223372036854775807);
    
}
