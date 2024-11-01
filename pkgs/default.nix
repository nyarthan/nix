{
  pkgs ? import <nixpkgs> { },
}:
{
  raycast = pkgs.callPackage ./raycast.nix { };
  geist = pkgs.callPackage ./geist.nix { };
  karabiner-driver = pkgs.callPackage ./karabiner-driver.nix { };
}
