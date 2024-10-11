{ pkgs, ... }:
{
  environment = {
    systemPackages = [
      pkgs.curl
      pkgs.vim
    ];
    darwinConfig = "/Users/jannis/nix/flake.nix";
  };
}
