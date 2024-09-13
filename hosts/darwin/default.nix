{
  pkgs,
  inputs,
  ...
}: {
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

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
    casks = [
      "steam"
      "protonvpn"
      "keymapp"
      "bitwarden"
      "affinity-photo"
      "affinity-designer"
      "affinity-publisher"
      "chatgpt"
      "figma"
      "obsidian"
      "onyx"
      "vmware-fusion"
      "pearcleaner"
      "app-cleaner"
    ];
    masApps = {
      AusweisApp = 948660805;
      Word = 462054704;
      Excel = 462058435;
    };
  };

  system.defaults = {
    dock.autohide = true;
    LaunchServices.LSQuarantine = false;
    NSGlobalDomain.AppleFontSmoothing = 2;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.swipescrolldirection" = true;
    dock.dashboard-in-overlay = true;
    dock.mru-spaces = true;
    dock.showhidden = true;
    finder.AppleShowAllFiles = true;
    finder.FXEnableExtensionChangeWarning = false;
    finder.QuitMenuItem = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    screencapture.location = "~/Pictures/screenshots";
  };
}
