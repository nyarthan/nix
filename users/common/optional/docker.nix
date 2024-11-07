# why do I need to define `pkgs` here? for some reason it's not included otherwise???????
let
  name = "docker";
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
        pkgs.docker
        pkgs.colima
      ];
    };
  }
)
