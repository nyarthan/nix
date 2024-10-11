{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.docker;
in
{
  options.custom.docker = {
    enable = lib.mkEnableOption "Enables docker";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.docker
      pkgs.colima
    ];
  };
}
