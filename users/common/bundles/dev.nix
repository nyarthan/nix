{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.bundle.dev;
in
{
  options.custom.bundle.dev = {
    enable = lib.mkEnableOption "dev bundle";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      fish.enable = true;
      bash.enable = true;
      starship.enable = true;
      direnv.enable = true;
      docker.enable = false;
      podman.enable = true;
      gh.enable = true;
      wezterm.enable = true;
      devenv.enable = true;
    };
  };
}
