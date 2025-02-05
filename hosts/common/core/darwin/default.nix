{ ... }:
{
  imports = [
    ../common

    ./documentation.nix
    ./nixpkgs.nix
    ./environment.nix
    ./homebrew.nix
    ./security.nix
    ./services.nix
    ./system.nix
  ];
}
