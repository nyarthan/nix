let
  name = "i3";
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
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.dmenu
        pkgs.i3lock
        pkgs.i3blocks
        pkgs.i3status
      ];

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          assigns = {
            "Web" = [ { class = "^Firefox$"; } ];
          };
          fonts = {
            names = config.custom.fonts.defaultFonts.monospace;
            style = "Bold";
            size = 11.0;
          };
          workspaceAutoBackAndForth = true;
          modifier = "Mod4"; # Super
          keybindings =
            let
              mod = config.xsession.windowManager.i3.config.modifier;
            in
            lib.mkOptionDefault {
              "${mod}+Return" = "exec ghostty";
              "${mod}+space" = "exec dmenu_run";
            };
        };
      };
    };
  }
)
