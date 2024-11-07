{ lib', pkgs, ... }:
{
  users.users.jannis = {
    description = "Primary Account";
    home = lib'.usersDirectory { inherit pkgs; } + "/jannis";
    isHidden = false;
    shell = pkgs.bashInteractive;
  };

  home-manager.users.jannis = import (lib'.relativeToRoot "users/jannis/default.nix");
  home-manager.backupFileExtension = "backup";
}
