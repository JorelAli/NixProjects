with builtins; let
  math = import ./math.nix;
in rec {

  # binary.nix
  # 
  # Represents binary numbers as a list of boolean values
  # true  = 1
  # false = 0
  # 
  # Example:
  # 8 -> [ true false false false ]

  # convertToBinary :: Int -> [ Bool ]
  convertToBinary = dec: idk;

  # convertToDecimal :: [ Bool ] -> Int
  convertToDecimal = bin: 
    let convertToDecimal' = bin: acc: 
      if bin == [] then acc
      else convertToDecimal' 
        (tail bin) 
        acc + ((math.pow 2 (length bin - 1)) * (if head bin then 1 else 0));
    in convertToDecimal' bin 0;

  
}
