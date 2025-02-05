{ ... }:
{
  imports = [
    ../common
    ./nixpkgs.nix
    ./sops.nix
    ./documentation.nix
    ./environment.nix
    ./nix.nix
  ];
}
