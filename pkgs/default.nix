{pkgs ? import <nixpkgs> {}}: rec {
  raycast = pkgs.callPackage ./raycast.nix {};
}
