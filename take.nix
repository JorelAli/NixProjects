rec {
  
  take = n: xs:
  if n == 0 then []
  else [(builtins.head xs)] ++ (take (n - 1) (builtins.tail xs));

}
