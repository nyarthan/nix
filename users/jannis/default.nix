{
  pkgs,
  inputs,
  lib',
  ...
}:
let
  username = "jannis";
in
{
  imports = [
    ../common/core
    ../common/optional
    ../common/bundles
  ];

  custom.bundle.dev.enable = true;
  custom.bundle.desktop.enable = true;
  custom.social.enable = true;
  custom.firefox.enable = true;

  home = {
    inherit username;
    homeDirectory = lib'.usersDirectory { inherit pkgs; } + "/${username}";
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
    inputs.neovim.packages.aarch64-darwin.default
    pkgs.cloc
    pkgs.tree
    pkgs.shortcat
  ];
}
