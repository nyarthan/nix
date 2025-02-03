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

  wayland.windowManager.hyprland.enable = true;

  home =
    let
      username = "jannis";
    in
    {
      inherit username;
      homeDirectory = lib'.usersDirectory { inherit pkgs; } + "/${username}";
      stateVersion = "24.05";
      packages = [
        pkgs.lazygit
        pkgs.zellij
        pkgs.ripgrep
        pkgs.vscode
        inputs.neovim.packages.aarch64-linux.default
      ];
    };
}
