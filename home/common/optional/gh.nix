{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "gh" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "Enables GitHub CLI (gh)";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.gh
      ];
    };
  }
)
