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
}
