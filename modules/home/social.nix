let
  name = "social";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  { cfg, lib, ... }:
  {

    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        # pkgs.slack
        pkgs.discord
        # pkgs.teams
      ];
    };
  }
)
