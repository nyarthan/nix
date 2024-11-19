let
  name = "wezterm";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
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
        type = lib.types.string;
        default = "IosevkaTermSlab Nerd Font";
        description = "Primary font family";
      };
    };

    config = lib.mkIf cfg.enable {
      programs.wezterm =
        let
          colorscheme = "vesper";
        in
        {
          enable = true;

          colorSchemes = {
            ${colorscheme} = {
              foreground = "#FFFFFF";
              background = "#101010";
              cursor_bg = "#FFC799";
              cursor_border = "#FFC799";
              cursor_fg = "#FFFFFF";
              selection_bg = "#232323";
              selection_fg = "#FFFFFF";
              ansi = [
                "#101010"
                "#f5a191"
                "#90b99f"
                "#e6b99d"
                "#aca1cf"
                "#e29eca"
                "#ea83a5"
                "#A0A0A0"
              ];
              brights = [
                "#7E7E7E"
                "#ff8080"
                "#99FFE4"
                "#FFC799"
                "#b9aeda"
                "#ecaad6"
                "#f591b2"
                "#ffffff"
              ];
              scrollbar_thumb = "#343434";
            };
          };

          extraConfig =
            # lua
            ''
              local term = require "wezterm"

              return {
                max_fps = 120,

                default_prog = { "${lib.meta.getExe' pkgs.fish "fish"}" },

                font_size = 14,
                font = term.font_with_fallback {
                  {
                    family = "${cfg.fontFamily}",
                    weight = "Medium",
                  },
                },
                font_rules = {
                  {
                    intensity = "Bold",
                    italic = false,
                    font = term.font_with_fallback {
                      family = "${cfg.fontFamily}",
                      weight = "ExtraBold",
                      italc = false,
                    },
                  },
                  {
                    intensity = "Bold",
                    italic = true,
                    font = term.font_with_fallback {
                      family = "${cfg.fontFamily}",
                      weight = "ExtraBold",
                      italc = true,
                    },
                  },
                },

                color_scheme = "${colorscheme}",

                scrollback_lines = 10000,

                window_padding = {
                  left = 0,
                  right = 0,
                  top = 0,
                  bottom = 0,
                },

                enable_tab_bar = false,
                hide_tab_bar_if_only_one_tab = true,

                -- cursor_blink_rate = 800,
                cursor_thickness = "0.1cell",
                custom_block_glyphs = true,
                default_cursor_style = "BlinkingBar",

                -- https://www.reddit.com/r/wezterm/comments/1eze6zt/colored_blocks_instead_of_text/
                front_end = "WebGpu",

                window_decorations = "RESIZE",
              }
            '';
        };
    };
  }
)
