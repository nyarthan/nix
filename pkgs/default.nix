{
  pkgs ? import <nixpkgs> { },
}:
{
  raycast = pkgs.callPackage ./raycast.nix { };
  geist = pkgs.callPackage ./geist.nix { };
}
