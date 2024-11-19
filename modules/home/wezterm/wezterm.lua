local term = require "wezterm"

local family = "IosevkaTermSlab Nerd Font"

return {
  max_fps = 120,

  default_prog = { "/etc/profiles/per-user/jannis/bin/fish" },

  font_size = 14,
  font = term.font_with_fallback {
    {
      family = family,
      weight = "Medium",
    },
  },
  font_rules = {
    {
      intensity = "Bold",
      italic = false,
      font = term.font_with_fallback {
        family = family,
        weight = "ExtraBold",
        italc = false,
      },
    },
    {
      intensity = "Bold",
      italic = true,
      font = term.font_with_fallback {
        family = family,
        weight = "ExtraBold",
        italc = true,
      },
    },
  },

  color_scheme = "tokyonight",
  colors = {
    foreground = "#FFFFFF",
    background = "#101010",
    cursor_bg = "#FFC799",
    cursor_border = "#FFC799",
    cursor_fg = "#FFFFFF",
    selection_bg = "#232323",
    selection_fg = "#FFFFFF",

    ansi = {
      "#101010",
      "#f5a191",
      "#90b99f",
      "#e6b99d",
      "#aca1cf",
      "#e29eca",
      "#ea83a5",
      "#A0A0A0",
    },
    brights = {
      "#7E7E7E",
      "#ff8080",
      "#99FFE4",
      "#FFC799",
      "#b9aeda",
      "#ecaad6",
      "#f591b2",
      "#ffffff",
    },

    scrollbar_thumb = "#343434",

    tab_bar = {
      background = "#101010",
      active_tab = {
        bg_color = "#161616",
        fg_color = "#FFFFFF",
      },
      inactive_tab = {
        bg_color = "#101010",
        fg_color = "#505050",
      },
      inactive_tab_hover = {
        bg_color = "#282828",
        fg_color = "#FFFFFF",
      },
      new_tab = {
        bg_color = "#101010",
        fg_color = "#505050",
      },
      new_tab_hover = {
        bg_color = "#282828",
        fg_color = "#FFFFFF",
      },
    },
  },

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
