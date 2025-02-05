{
  inputs,
  lib',
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = lib'.relativeToRoot "secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/id_ed25519" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      jannis-email = { };
    };
  };
}
