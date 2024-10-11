{ pkgs, neovim, ... }:
{
  imports = [
    ../common/optional
    ../common/bundles/dev.nix
  ];

  custom.bundle.dev.enable = true;
  custom.social.enable = true;

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
    neovim.packages.aarch64-darwin.default
  ];
}
