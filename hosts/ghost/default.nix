{ ... }:
{
  imports = [
    ../common/core
    ../common/core/darwin
    ../common/users/jannis
  ];

  custom = {
    bash.enable = false;
    karabiner-driver.enable = true;
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
