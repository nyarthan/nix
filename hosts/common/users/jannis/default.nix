{ configLib, pkgs, ... }:
{
  users.users.jannis = {
    description = "Primary Account";
    home = configLib.usersDirectory { inherit pkgs; } + "/jannis";
    isHidden = false;
  };

  home-manager.users.jannis = import (configLib.relativeToRoot "home/jannis/darwin.nix");
}
