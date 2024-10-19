{ lib', pkgs, ... }:
{
  users.users.jannis = {
    description = "Primary Account";
    home = lib'.usersDirectory { inherit pkgs; } + "/jannis";
    isHidden = false;
  };

  home-manager.users.jannis = import (lib'.relativeToRoot "home/jannis/darwin.nix");
}
