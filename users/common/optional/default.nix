{ lib', ... }:
{
  imports = [
    (lib'.relativeToRoot "modules/home/fish.nix")
    (lib'.relativeToRoot "modules/home/bash.nix")
    (lib'.relativeToRoot "modules/home/starship.nix")
    (lib'.relativeToRoot "modules/home/direnv.nix")
    (lib'.relativeToRoot "modules/home/docker.nix")
    (lib'.relativeToRoot "modules/home/podman.nix")
    (lib'.relativeToRoot "modules/home/social.nix")
    (lib'.relativeToRoot "modules/home/aerospace")
    (lib'.relativeToRoot "modules/home/gh.nix")
    (lib'.relativeToRoot "modules/home/sops.nix")
    (lib'.relativeToRoot "modules/home/wezterm.nix")
    (lib'.relativeToRoot "modules/home/ghostty.nix")
    (lib'.relativeToRoot "modules/home/tmux.nix")
    (lib'.relativeToRoot "modules/home/i3.nix")
    (lib'.relativeToRoot "modules/home/devenv.nix")
    (lib'.relativeToRoot "modules/home/act.nix")
  ];
}
