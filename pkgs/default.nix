{
  pkgs ? import <nixpkgs> { },
}:
{
  raycast = pkgs.callPackage ./raycast.nix { };
}
