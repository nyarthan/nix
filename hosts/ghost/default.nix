{ ... }:
{
  imports = [
    ../common/core
    ../common/core/darwin
    ../common/users/jannis/darwin.nix
  ];

  custom = {
    bash.enable = true;
    karabiner-driver.enable = true;
    stirling-pdf.enable = false;
  };

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
