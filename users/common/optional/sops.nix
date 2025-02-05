let
  name = "sops";
in
{ lib', ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    inputs,
    ...
  }:
  {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      sops = {
        age.keyFile = "/home/jannis/.config/sops/age/keys.txt";

        defaultSopsFile = lib'.relativeToRoot "secrets.yaml";
        validateSopsFiles = false;

        secrets = {
          "private_keys/jannis" = {
            path = "/home/jannis/.ssh/id_ed25519";
          };
        };
      };
    };
  }
)
