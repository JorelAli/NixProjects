with builtins;

let 
  math = import ./math.nix;
  
  # strToList :: String -> [ String ]
  strToList = str:
    let strToList' = str: acc: 
      if str == "" then acc
      else strToList' 
        (substring 1 (stringLength str) str) 
        (acc ++ [(substring 0 1 str)]);    
    in strToList' str [];
    
  # listToStr :: [ String ] -> String
  listToStr = list: foldl' (acc: x: acc + x) "" list;

  # strListToIntList :: [ String ] -> [ Int ]
  strListToIntList = strList: map math.toInt strList;

  # intListToStrList :: [ Int ] -> [ String ]
  intListToStrList = intList: map toString intList;

  reverseList = list: foldl' (acc: x: [x] ++ acc) [] list;

  # patchLists :: [ Int ] -> [ Int ] -> Attrs
  # patchLists [ 1 2 3 ] [ 1 0 ] = { left = [ 1 2 3 ]; right = [ 0 1 0 ]; }
  patchLists = l: r: 
    if length l > length r then {
      left = l;
      right = foldl' (acc: x: [x] ++ acc) r (genList (x: 0) (length l - length r));
    } else {
      left = foldl' (acc: x: [x] ++ acc) l (genList (x: 0) (length r - length l));
      right = r;
    };

  # lXor :: Bool -> Bool -> Bool
  # (Logical XOR)
  lXor = b1: b2: !(b1 == b2);

in rec {

  ### BigInteger Constructors #############################

  ###################################################################
  # BigInteger specification:                                       #
  # __toString = The String representation of a number (e.g. "123") #
  # value      = An int list of each digit (e.g. [ 1 2 3 ] )        #
  # sign       = Whether positive or negative. true => positive     #
  ###################################################################

  # create :: String -> BigInteger
  create = str':
    let 
      str = if substring 0 1 str' == "-" 
        then substring 1 (stringLength str') str'
        else str';
    in {
    __toString = self: 
      (if self.sign then "" else "-")
      + listToStr (intListToStrList self.value);
    value = strListToIntList (strToList str);
    sign = !(substring 0 1 str' == "-");
  };

  # create' :: [ Int ] -> Bool -> BigInteger
  create' = iList: sign: 
    create ((if sign then "" else "-") + listToStr (intListToStrList (iList)));

  ### BigInteger Operations ###############################

  # add :: BigInteger -> BigInteger -> BigInteger
  add = bigInt1: bigInt2: let
    # add' :: [ Int ] -> [ Int ] -> Int -> [ Int ] -> [ Int ]
    add' = bigInt1': bigInt2': carry: acc: 
    let nums = patchLists bigInt1' bigInt2';
        bigInt1 = nums.left;
        bigInt2 = nums.right;
        last1 = head (reverseList bigInt1);
        last2 = head (reverseList bigInt2);
        digitSum = last1 + last2;
        new1  = reverseList (tail (reverseList bigInt1));
        new2  = reverseList (tail (reverseList bigInt2));
    in
      if bigInt1 == [] && bigInt2 == [] then 
        if carry == 0 then acc
        else [carry] ++ acc
      else
        if digitSum + carry >= 10 then
          add' new1 new2 1 ([(digitSum - 10 + carry)] ++ acc)
        else 
          add' new1 new2 0 ([(digitSum + carry)] ++ acc); in
    create' (add' bigInt1.value bigInt2.value 0 []) true;


  
  

}
