{ pkgs, ... }:
let
  inherit (pkgs) lib;
in
{
  relativeToRoot = lib.path.append ../.;

  usersDirectory =
    { pkgs }:
    if pkgs.stdenv.isLinux then
      "/home"
    else if pkgs.stdenv.isDarwin then
      "/Users"
    else
      throw "Unsupported System";

  mkCustomModule =
    attrPath: inputs: moduleFn:
    let
      cfg = lib.attrsets.getAttrFromPath attrPath inputs.config.custom;
      module = moduleFn (inputs // { inherit cfg options; });
      options = lib.attrsets.setAttrByPath ([ "custom" ] ++ attrPath) module.options;
    in
    module // { inherit options; };
}
