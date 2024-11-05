{ pkgs, ... }:
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
    ../common/core/darwin/services.nix
    ../common/users/jannis
  ];

  custom = {
    bash.enable = false;
    karabiner-driver.enable = true;
  };

  fonts.packages = [ pkgs.nerdfonts ];

  # sops = {
  #   secrets.jannis-password = { };
  #   defaultSopsFile = ../../secrets.yaml;
  #   validateSopsFiles = false;
  #   age = {
  #     sshKeyPaths = [ "/etc/ssh/id_host_ed25519" ];
  #     keyFile = "/var/lib/sops-nix/key.txt";
  #     generateKey = true;
  #   };
  # };
}
