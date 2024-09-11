{pkgs, ...}: {
  home = {
    username = "jannis";
    homeDirectory = "/Users/jannis";
    stateVersion = "24.05";
  };

  programs.fish.enable = true;
  # fucks up starship integration
  # programs.fish.interactiveShellInit = ''
  #   zellij
  # '';
  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;

  home.packages = with pkgs; [
    slack
    whatsapp-for-mac
    discord
    teams
    qbittorrent
    spotify
    tableplus
    wezterm
    lazygit
    zellij
  ];
}
