{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "aerospace" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "enables aerospace window manager";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.aerospace
      ];

      home.file.".aerospace.toml".source = ./aerospace.toml;
    };
  }
)
