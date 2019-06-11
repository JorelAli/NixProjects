int: builtins.foldl' 
  (xs: x: 
    if (builtins.elem (x / 2) xs) 
      then xs 
      else (xs ++ [x])  
  ) [] (builtins.genList (x: x) int)
