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
    };

    bash.enable = true;
    sops.enable = true;
    ghostty.enable = true;
    tmux.enable = true;

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
      packages = [
        pkgs.lazygit
        pkgs.zellij
        pkgs.ripgrep
        pkgs.vscode
        pkgs.cargo
        pkgs.rustc
        pkgs.gcc
        inputs.neovim.packages.x86_64-linux.default
      ];
    };
}
