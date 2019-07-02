with builtins; rec {
  # union :: Attrs -> Attrs -> Attrs
  union = attrs1: attrs2: attrs1 // attrs2;

  # intersect :: Attrs -> Attrs -> Attrs
  intersect = attrs1: attrs2: intersectAttrs attrs1 attrs2;

  # difference :: Attrs -> Attrs -> Attrs
  difference = attrs1: attrs2: 
    filterAttrs attrs1 (k: v: !attrs2 ? "${k}");

  # filterAttrs :: Attrs -> (String -> * -> Bool) -> Attrs
  filterAttrs = attrs: predicate: 
    let attrs' = mapAttrs (k: v: if predicate k v then v else null) attrs;
        nulls  = foldl' (acc: x: acc ++ (if attrs'."${x}" == null then [x] else [])) [] (attrNames attrs');
    in
      removeAttrs attrs' nulls;
}
