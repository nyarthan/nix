{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.vim
  ];
  imports = [
    ../common/core
    ../common/users/jannis
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
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

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 4;

    defaults = {
      dock = {
        autohide = true;
        dashboard-in-overlay = true;
        mru-spaces = true;
        showhidden = true;
      };
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        AppleFontSmoothing = 2;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        "com.apple.keyboard.fnState" = true;
        "com.apple.swipescrolldirection" = true;
      };
      finder = {
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      screencapture.location = "~/Pictures/screenshots";
    };
  };
}
