with builtins; 
with import <nixpkgs> {}; 
rec {

  exampleFile = /nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/config/appstream.nix;

  exampleFile2 = /nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/system/boot/kernel.nix;

  nixModules = <nixos> + "/nixos/modules";

  testSet = getNixOptions exampleFile;

  filterList = [ "clone-config.nix" "nixpkgs.nix" "version.nix" "virtualbox.nix" 
    "broadcom-43xx.nix" 
    "radeon.nix"
    "uvcdynctrl-udev-rules.nix"
    "nix-fallback-paths.nix"
    "build-vms.nix"
    "documentation.nix"
    "conf.nix"
    "controller-manager.nix"
    "kubelet.nix"
    "proxy.nix"
    "scheduler.nix"
    "neo4j.nix"
  ];

  a' = getAllNixOptions nixModules;

  getAllNixOptions = nodeDir: 
    let listOfNixFiles = filter (x: !elem (baseNameOf x) filterList) (getAllNixFiles nodeDir); in
    foldl' (acc: file: acc ++ trace ( file) (parseOptions (getNixOptions file))) [] (sort lessThan listOfNixFiles)

    #For all dirs in createDirTree
      # For all getNixFiles in dirs
        # parseOptions
    ;

  getAllNixFiles = nodeDir:
    foldl' (acc: dir: acc ++ (getNixFiles dir)) [] (createDirTree nodeDir);


  # Attrs -> [ Attrs ]
  # { a = {}; } -> [ { a = {} } ]
  innerSets' = set: 
    foldl' (acc: attrName:
      acc ++ [
      { name = attrName; value = (if isAttrs set."${attrName}" then set."${attrName}" else null); }
      ]

    ) [] (attrNames set);

  parseOptions = optionSet: parseOptions'' "" optionSet [];

  parseOptions'' = parent: optionSet: acc:
  if optionSet ? _type then [] else

    acc ++ /*(attrNames optionSet) ++ */
    foldl' (a: {name, value}@setKP: 
      a 
      ++ [ (parent +"${if stringLength parent != 0 then "." else ""}" +name) ]
      ++ (if value != null then parseOptions'' name value [] else [])
    ) [] (innerSets' optionSet);

#  parseOptions' = optionSet:
#    lib.flatten (parseOptions "" optionSet []);

#  parseOptions = optionSet: 
#    let nestedOptions = parseOptions' optionSet []; in 
#    #TODO: "Un-nest" them and concat parent values to inside stuff
#    nestedOptions;
#
#  parseOptions' = optionSet: acc:
#    if optionSet ? _type then acc
#    else let innerOptions = 
#    foldl' (a: x: a ++ [(getAttr x optionSet)]) [] (attrNames optionSet); in
#      acc ++ (attrNames optionSet) ++ 
#      (foldl' (a: x: a ++ [(parseOptions x)]) [] innerOptions );

#    parseOptions = parentOptionName: optionSet: acc: 
#      if !(isAttrs optionSet) then acc else
#      if optionSet ? _type then acc
#      else let
#      innerOptions = 
#        foldl' (a: x: a ++ [(getAttr x optionSet)]) [] (attrNames optionSet);
#      in acc
#        ++ (builtins.map (z: if (isString z) then "${parentOptionName}.${z}" else z) (attrNames optionSet))#(map (x: parentOptionName + "." + x) (attrNames optionSet))
#        ++ (foldl' (a: x: a ++ [(parseOptions (reverseLookup optionSet x) x/*(getAttr x optionSet)*/ [])]) [] innerOptions)
#      ;

#    reverseLookup = outerSet: innerObj: 
#      let vals = (attrValues outerSet);
#      in head (foldl' (acc: x: acc ++ [(if outerSet."${x}" == innerObj then x else [])]) [] (attrNames outerSet));
  
  getNixOptions = nixFile: 
    let parsedNixFile = import nixFile ((import <nixos> {}) // {utils={};}); in #{inherit pkgs config lib stdenv buildEnv libwebcam makeWrapper; 
#      utils={}; #baseModules={}; #options=(x: x); 
#    }; in
#      if parsedNixFile.success then trace parsedNixFile.value parsedNixFile.value#.options
#      else {};
    if parsedNixFile ? options
    then /*trace ("Parsing: " + baseNameOf nixFile)*/ parsedNixFile.options 
    else trace ("No options found in: " + baseNameOf nixFile) {};
#    trace ("Parsing: " + baseNameOf nixFile)
#    parsedNixFile.options;
  
  createDirTree = nodeDir:
    let nodeDir' = toString nodeDir; in
    lib.flatten (createDirTree' nodeDir' []);

  createDirTree' = nodeDir: dirAcc: 
    let contents = readDir nodeDir;
        names = attrNames contents;
        directories = filter (x: contents."${x}" == "directory") names;
    in 
      if length directories == 0 then dirAcc
      else let browsed = foldl' (acc: x: acc ++ [(nodeDir + "/" + x)]) [] directories; in
      foldl' (acc: x: acc ++ [(createDirTree' x dirAcc)]) (dirAcc ++ browsed) browsed;

  getNixFiles = dir: 
  let dir' = fixDirName dir;
      fileNames = (attrNames (readDir dir')); 
      nixFiles = filter (x: lastElement (split "\\." x) == "nix") fileNames;
  in map (x: dir' + x) nixFiles;

  lastElement = list: 
    if length list == 1 then head list
    else lastElement (tail list);

  lastChar = str:
    substring (stringLength str - 1) (stringLength str);

  fixDirName = dir: 
    let dir' = toString dir; in
    if lastChar dir' == "/" then dir'
    else dir' + "/";

}
