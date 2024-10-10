{ pkgs, neovim, ... }:
{
  home = {
    username = "jannis";
    homeDirectory = "/Users/jannis";
    stateVersion = "24.05";
  };

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    fish_add_path /opt/homebrew/Cellar/postgresql@16/16.4/bin
  '';
  programs.fish.functions = {
    docker = {
      body = ''
        function start_docker_if_needed
          if not test -S ~/.colima/default/docker.sock
            echo "Starting Colima..."
            colima start
          end
        end

        start_docker_if_needed
        command docker $argv
      '';
    };
  };
  # fucks up starship integration
  # programs.fish.interactiveShellInit = ''
  #   zellij
  # '';
  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = [
    pkgs.slack
    # pkgs.whatsapp-for-mac
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
    # pkgs.raycast
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
