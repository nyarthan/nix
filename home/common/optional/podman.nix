{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "podman" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "Enables podman";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.podman
      ];
    };
  }
)
