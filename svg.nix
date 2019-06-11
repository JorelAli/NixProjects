with builtins; rec {

/* Examples:
file = toSVG {y=80;} [ (rect {width=100; height=20;}) (circle {x=50;y=40;radius=3
file = toSVG {y=80;} [ (rect {width=100; height=20;}) (circle {x=50;y=40;radius=10;}) (rect {y=60;width=100;height=20;})] 

builtins.toFile "my.svg" file
*/

  toSVG = let 
    xmlHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>";


  in {startX ? 0, startY ? 0, x ? 100, y ? 100}: xs: 
  let 
    svgHeader = "<svg viewBox=\"${toString startX} ${toString startY} ${toString x} ${toString y}\" xmlns=\"http://www.w3.org/2000/svg\">"; 
  in (foldl' (acc: x: acc + "\n    " + x) (xmlHeader + "\n" + svgHeader) xs) + "\n</svg>";

  circle = {x ? 0, y ? 0, radius}: 
  "<circle cx=\"${toString x}\" cy=\"${toString y}\" r=\"${toString radius}\"/>";

  rect = {x ? 0, y ? 0, width, height, rounded ? 0}:
  let 
    xVal = if x != 0 then "x=\"${toString x}\" " else "";
    yVal = if y != 0 then "y=\"${toString y}\" " else "";
    wVal = "width=\"${toString width}\" ";
    hVal = "height=\"${toString height}\" ";
    rxVal = if rounded != 0 then "rx=\"${toString rounded}\" " else "";
  in "<rect ${xVal}${yVal}${wVal}${hVal}${rxVal}/>";
}
