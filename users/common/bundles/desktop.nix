{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.bundle.desktop;
in
{
  options.custom.bundle.desktop = {
    enable = lib.mkEnableOption "Enables desktop bundle";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      aerospace.enable = true;
    };
  };
}
