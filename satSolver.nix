with builtins; rec {

  /* 
    Runs a SAT solver on a function and the number of atoms declared in that function,
    then outputs a single valid valuation that satisfies the expression

    For example:

      satSolver (a: b: a -> b) 2 
      => trace: Found a valid valuation: [true,true]
         true 

    satSolve :: (a -> ... -> bool) -> int -> bool
  */
  satSolve = func: numAtoms: 
  let boolsPowerset = permuteBools numAtoms; in
  let result = any (bools: printStatus bools func) boolsPowerset; in
    if !result
    then trace "Expression not satisfiable" result
    else result;

  /* Prints all valuations which satisfy the input expression (see satSolve) */
  satSolvePrintAll = func: numAtoms: 
    foldl' (acc: bools: printStatus bools func) [] (permuteBools numAtoms);

  printStatus = bools: func: 
    let result = apply func bools; in
    if result 
      then trace "Found a valid valuation: ${builtins.toJSON bools}" result 
      else result;

  /* 
    Applies a list of bools to a function

    apply :: (a -> ... -> bool) -> [bool] -> bool

    apply (a: b: a -> b) [true false]
    => (b: true -> b)
    => (true -> false)
    => false
  */
  apply = func: bools: 
    if bools == [] then func
    else apply (func (head bools)) (tail bools); 
    
  /*
    Produces a permutation of all lists of bools of size x

    permuteBools :: int -> [[bool]]

    permuteBools 2
    => [[true true] [true false] [false true] [false false]]
  */
  permuteBools = x: let concat = a: b: a ++ b; in
  if x == 0 then [[]] 
  else let ys = permuteBools (x - 1); in 
    (map (concat [true]) ys) ++ (map (concat [false]) ys);

}
