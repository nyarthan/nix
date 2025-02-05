let
  name = "ghostty";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    config,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;

      fontSize = lib.mkOption {
        type = lib.types.int;
        default = 14;
        description = "Font size";
      };

      fontFamily = lib.mkOption {
        type = lib.types.listOf lib.types.string;
        default = config.custom.fonts.defaultFonts.monospace;
        description = "Primary font family";
      };
    };

    config = lib.mkIf cfg.enable {
      programs.ghostty = {
        enable = true;
        enableFishIntegration = lib.mkIf config.custom.fish.enable true;
        enableBashIntegration = lib.mkIf config.custom.bash.enable true;
        settings = {
          theme = "3024 Night";
        };
      };
    };
  }
)
