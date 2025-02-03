{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/core
    # ../common/core/nixos
    ../common/users/jannis/nixos.nix
  ];

  boot.loader.grub.device = "/dev/disk/by-label/NIXBOOT";

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
