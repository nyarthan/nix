{ pkgs, neovim, ... }:
{
  imports = [
    ../common/optional
    ../common/bundles/dev.nix
    ../common/bundles/desktop.nix
  ];

  custom.bundle.dev.enable = true;
  custom.bundle.desktop.enable = true;
  custom.social.enable = true;
  custom.firefox.enable = true;

  home = {
    username = "jannis";
    homeDirectory = "/Users/jannis";
    stateVersion = "24.05";
  };

  home.packages = [
    pkgs.qbittorrent
    pkgs.spotify
    pkgs.tableplus
    pkgs.wezterm
    pkgs.lazygit
    pkgs.zellij
    pkgs.ripgrep
    pkgs.vscode
    pkgs.karabiner-driver
    neovim.packages.aarch64-darwin.default
  ];
}
