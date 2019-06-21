rec {
  __functor = self: int: 
    if self ? ${toString int} 
      then self.${toString int} 
      else self.fail;
  fail = abort "Nah fam, you gon to far";
  "0" = [ false ];
  "1" = [ true ];
  "2" = [ true false ];
  "3" = [ true true ];
  "4" = [ true false false ];
  "5" = [ true false true ];
  "6" = [ true true false ];
  "7" = [ true true true ];
  "8" = [ true false false false ];
  /* TODO: More numbers */
}
