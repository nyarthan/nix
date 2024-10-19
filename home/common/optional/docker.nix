# why do I need to define `pkgs` here? for some reason it's not included otherwise???????
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "docker" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "Enables docker";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.docker
        pkgs.colima
      ];
    };
  }
)
