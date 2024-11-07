{ lib, ... }:
{
  imports = [
    ./git.nix
  ];

  # custom.git.enable = lib.mkDefault true;
}
