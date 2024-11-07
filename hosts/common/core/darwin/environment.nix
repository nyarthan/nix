{ pkgs, lib', ... }:
{
  environment = {
    systemPackages = [
      pkgs.curl
      pkgs.vim
    ];
    darwinConfig = lib'.usersDirectory { inherit pkgs; } + "/jannis/nix/flake.nix";
    shells = [ pkgs.bashInteractive ];
  };
}
