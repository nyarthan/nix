{ pkgs, neovim, ... }:
{
  imports = [
    ../common/optional
  ];

  custom.fish.enable = true;
  custom.starship.enable = true;
  custom.direnv.enable = true;

  home = {
    username = "jannis";
    homeDirectory = "/Users/jannis";
    stateVersion = "24.05";
  };

  home.packages = [
    pkgs.slack
    pkgs.discord
    pkgs.teams
    pkgs.qbittorrent
    pkgs.spotify
    pkgs.tableplus
    pkgs.wezterm
    pkgs.lazygit
    pkgs.zellij
    pkgs.ripgrep
    pkgs.docker
    pkgs.colima
    pkgs.diskonaut
    pkgs.nixd
    pkgs.statix
    pkgs.stylua
    pkgs.nodejs_20
    pkgs.pnpm
    pkgs.nodePackages.prettier
    pkgs.closurecompiler
    pkgs.yazi
    pkgs.efm-langserver
    pkgs.starship
    pkgs.vscode
    neovim.packages.aarch64-darwin.default
    pkgs.nixfmt-rfc-style
    pkgs.luajit
    pkgs.pkg-config
    pkgs.net-news-wire
    pkgs.nix-output-monitor
    pkgs.wireshark
  ];
}
