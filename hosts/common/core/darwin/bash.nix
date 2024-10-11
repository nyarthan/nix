{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.bash;
in
{
  options.custom.bash = {
    enable = lib.mkEnableOption "Enables bash";
  };

  config = {
    programs.bash = lib.mkIf cfg.enable {
      enable = true;
      completion.enable = true;
    };
  };
}
