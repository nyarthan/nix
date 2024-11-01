{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.starship;
in
{
  options.custom.starship = {
    enable = lib.mkEnableOption "Enables starship";
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
