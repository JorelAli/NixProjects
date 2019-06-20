with builtins;
let 
  readLine = msg: exec "/home/jorel/github/NixProjects/b" ++ [msg];
  getNum = let 
    input = readLine "Enter your favourite number from 1-10: ";
    in 2;
in 
  seq (readLine "hello") ()
