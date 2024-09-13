{pkgs, ...}: {
  home = {
    username = "jannis";
    homeDirectory = "/Users/jannis";
    stateVersion = "24.05";
  };

  programs.fish.enable = true;
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

  home.packages = [
    pkgs.slack
    pkgs.whatsapp-for-mac
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
    pkgs.raycast
  ];
}
