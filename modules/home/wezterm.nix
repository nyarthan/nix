let
  name = "wezterm";
in
{ lib', ... }@inputs:
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
        type = lib.types.listOf lib.types.str;
        default = config.custom.fonts.defaultFonts.monospace;
        description = "Primary font family";
      };
    };

    config = lib.mkIf cfg.enable {
      programs.wezterm = {
        enable = true;

        extraConfig =
          # lua
          ''
            local wezterm = require("wezterm")

            local config = wezterm.config_builder()

            -- display_pixel_geometry = "BGR"

            config.default_prog = { "/etc/profiles/per-user/jannis/bin/nu", "-c", "/etc/profiles/per-user/jannis/bin/tmux"}

            config.color_scheme = "Black Metal (Gorgoroth) (base16)"

            config.font = wezterm.font_with_fallback({
              "Iosevka",
            })
            config.font_size = 14

            config.window_background_opacity = 0.8
            config.macos_window_background_blur = 20

            config.front_end = "WebGpu"
            config.webgpu_power_preference = "HighPerformance"
            config.prefer_egl = false

            -- tmux handles scrollback
            config.scrollback_lines = 0

            config.enable_tab_bar = false
            config.window_decorations = "RESIZE"
            config.window_padding = {
              left = 0,
              right = 0,
              top = 0,
              bottom = 0
            }

            config.max_fps = 120

            config.audible_bell = "Disabled"
            config.check_for_updates = false

            return config
          '';
      };
    };
  }
)
