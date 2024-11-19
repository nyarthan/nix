let
  name = "fonts";
in
{ lib', ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;

      fonts = lib.mkOption {
        type = lib.types.listOf lib.types.package;
      };

      defaultFonts = lib.mkOption {
        type = lib.types.submodule {
          options =
            let
              fontOption = lib.mkOption {
                type = lib.types.listOf lib.types.string;
                default = [ ];
              };
            in
            {
              emoji = fontOption;
              monospace = fontOption;
              sansSerif = fontOption;
              serif = fontOption;
            };
        };
      };
    };

    config = lib.mkIf cfg.enable {
      fonts.fontconfig = {
        enable = true;
        defaultFonts = cfg.defaultFonts;
      };

      home.packages = cfg.fonts;
    };
  }
)
