{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../common/core
    ../common/core/darwin/bash.nix
    ../common/core/darwin/documentation.nix
    ../common/core/darwin/environment.nix
    ../common/core/darwin/fonts.nix
    ../common/core/darwin/homebrew.nix
    ../common/core/darwin/nix.nix
    ../common/core/darwin/nixpkgs.nix
    ../common/core/darwin/security.nix
    ../common/core/darwin/system.nix
    ../common/users/jannis
  ];

  environment.systemPackages = [
    pkgs.vim
  ];

  custom = {
    bash.enable = true;
  };

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;
    age = {
      sshKeyPaths = [ "/etc/ssh/id_host_ed25519" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 5;

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
