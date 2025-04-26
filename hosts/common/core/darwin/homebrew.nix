{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
    global = {
      brewfile = true;
    };

    casks = [
      "protonvpn"
      "vmware-fusion"
      "whatsapp@beta"
      "raycast"
      "obsidian"
      "vlc"
      "zen-browser"
    ];

    # masApps = {
    #   AusweisApp = 948660805;
    #   Word = 462054704;
    #   Excel = 462058435;
    #   Bitwarden = 1352778147;
    # };
  };

}
