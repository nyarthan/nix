{
  pkgs,
  config,
  system,
  inputs,
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
    pkgs.treefmt
    inputs.nix-auto-follow.packages.${system}.default
  ];

  shellHook = ''
    cp -f ${config.treefmt.build.configFile} treefmt.toml
  '';
}
