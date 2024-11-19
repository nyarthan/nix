let
  name = "wezterm";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.wezterm
      ];

      xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
    };
  }
)
