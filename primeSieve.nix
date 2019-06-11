with builtins; with import ./math.nix; rec {
  
  # Initial list of numbers of 2 to max + 1
  # initList :: int -> [int]
  initList = max: genList (x: x + 2) max;

  # newList :: int -> [int] -> [int]
  newList = cNum: list: 
    (filter (x: mod x cNum != 0) list) ++ [cNum];

  # makePrimeSieve :: int -> [int]
  makePrimeSieve = num: 
    let nList = newList 2 (initList num); in
      sieve (head nList) nList;
  
  # sieve :: int -> [int] -> [int]
  sieve = cNum: list:
    if head list == 2 
      then list
      else 
        let getNewList = newList (head list) list; in 
          sieve (head getNewList) getNewList;
    

}
