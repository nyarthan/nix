{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.social;
in
{
  options.custom.social = {
    enable = lib.mkEnableOption "Enables social stuff";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.slack
      pkgs.discord
      pkgs.teams
    ];
  };
}
