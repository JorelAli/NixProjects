with import <nixpkgs/nixos> {}; with builtins;

{
  inherit config;


  # filterAttrs :: Attrs -> Attrs 
  filterAttrs = attrs: 
    let attrs' = mapAttrs (k: v: if (tryEval v).success && (isAttrs v) then v else null) attrs;
        nullNames = foldl' 
          (acc: x: acc ++ (if attrs'."${x}" == null then [x] else [])) 
          [] 
          (attrNames attrs');
    in
      removeAttrs attrs' nullNames;
    

}
