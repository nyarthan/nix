{
  pkgs,
  config,
  ...
}:
pkgs.mkShell {
  name = "nix-config";

  packages = [
    # pkgs.sops
    pkgs.age
    pkgs.sops
    pkgs.ssh-to-age
    pkgs.mkpasswd
    pkgs.mask
  ];
}
