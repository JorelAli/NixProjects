with import <nixpkgs/nixos> {}; with builtins; with import ./attrs.nix;

rec {
  inherit config;

  generateOptions = generateOptions' [] config null;

  generateOptions' = acc: attrs: parent:
    let moreAttrs = filterValidAttrs attrs;
        options = convertToStr attrs parent;
    in
      acc ++ options;# ++ generateOptions' [] attrs "eh";

  filterValidAttrs = attrs: 
    filterAttrs attrs (k: v: (tryEval v).success && (isAttrs v));
  
   filterOptions = attrs:
    filterAttrs attrs (k: v: (tryEval v).success && !isAttrs v);

  convertToStr = attrs: parent:
    let dot = if parent == null then "" else ".";
        parent' = if parent == null then "" else parent;
        strs = attrNames (filterOptions attrs);
    in map (x: parent' + dot + x) strs;
    

}
