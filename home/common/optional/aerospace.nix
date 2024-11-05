let
  name = "aerospace";
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
        pkgs.aerospace
      ];

      home.file.".aerospace.toml".source = ./aerospace.toml;
    };
  }
)
