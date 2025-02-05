{ lib', ... }:
{
  imports = [
    ./fish.nix
    ./bash.nix
    ./starship.nix
    ./direnv.nix
    ./docker.nix
    ./podman.nix
    ./social.nix
    ./aerospace
    ./firefox.nix
    ./gh.nix
    ./sops.nix
    (lib'.relativeToRoot "modules/home/wezterm.nix")
  ];
}
