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
      "steam"
      "protonvpn"
      "affinity-photo"
      "affinity-designer"
      "affinity-publisher"
      "figma"
      "vmware-fusion"
      "whatsapp@beta"
      "raycast"
      "obsidian"
      "vlc"
      "ghostty"
      "gather"
      "zen-browser"
    ];

    masApps = {
      AusweisApp = 948660805;
      Word = 462054704;
      Excel = 462058435;
      Bitwarden = 1352778147;
    };
  };

}
