{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.direnv;
in
{
  options.custom.direnv = {
    enable = lib.mkEnableOption "Enables direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
