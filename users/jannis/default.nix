{
  pkgs,
  inputs,
  lib',
  ...
}:
{
  imports = [
    ../common/core
    ../common/optional
    ../common/bundles
    (lib'.relativeToRoot "modules/home/fonts.nix")
  ];

  custom = {
    bundle = {
      dev.enable = true;
      desktop.enable = true;
    };

    social.enable = true;
    ghostty.enable = true;
    nushell.enable = true;

    fonts = {
      enable = true;
      fonts = [
        pkgs.iosevka
        # (pkgs.iosevka.override {
        #   privateBuildPlan = ''
        #     [buildPlans.IosevkaCustom]
        #     family = "Iosevka Custom"
        #     spacing = "term"
        #     serifs = "slab"
        #     noCvSs = true
        #     exportGlyphNames = false
        #   '';
        #   set = "Custom";
        # })
        pkgs.geist-font
      ];

      defaultFonts = {
        monospace = [ "Iosevka Custom" ];
        sansSerif = [ "Geist" ];
        serif = [ "Geist" ];
      };
    };
  };

  home =
    let
      username = "jannis";
    in
    {
      inherit username;
      homeDirectory = lib'.usersDirectory { inherit pkgs; } + "/${username}";
      stateVersion = "25.05";
      sessionVariables = {
        PNPM_HOME = "/Users/jannis/Library/pnpm";
      };
      sessionPath = [ "/Users/jannis/Library/pnpm" ];
      packages = [
        pkgs.qbittorrent
        pkgs.spotify
        pkgs.tableplus
        pkgs.lazygit
        pkgs.zellij
        pkgs.ripgrep
        pkgs.vscode
        pkgs.karabiner-driver
        inputs.neovim.packages.aarch64-darwin.default
        pkgs.gather
        pkgs.figma
        pkgs.cloc
        pkgs.tree
        pkgs.karabiner-elements
        pkgs.gdu
        pkgs.tmux
        pkgs.hyperfine
        pkgs.karabiner-elements
        pkgs.zen-browser
        pkgs.whatsapp
        # pkgs.protonvpn
        pkgs.nushell
        pkgs.dust
        pkgs.hyperfine
        pkgs.yazi
        pkgs.mask
        pkgs.delta
      ];
    };
}
