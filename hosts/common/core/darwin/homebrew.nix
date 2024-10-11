{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
    global = {
      brewfile = true;
    };

    brews = [
      {
        name = "postgresql@16";
        start_service = true;
        restart_service = true;
      }
    ];

    casks = [
      "steam"
      "protonvpn"
      "keymapp"
      "affinity-photo"
      "affinity-designer"
      "affinity-publisher"
      "chatgpt"
      "figma"
      "onyx"
      "vmware-fusion"
      "pearcleaner"
      "app-cleaner"
      "whatsapp@beta"
      "raycast"
      "obsidian"
      "steam"
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
