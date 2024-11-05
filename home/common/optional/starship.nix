let
  name = "starship";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    cfg,
    lib,
    config,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      programs.starship = {
        enable = true;
        enableFishIntegration = lib.mkIf config.custom.fish.enable true;
        enableBashIntegration = lib.mkIf config.custom.bash.enable true;
      };

      home.packages = [ pkgs.nodejs_20 ];
    };
  }
)
