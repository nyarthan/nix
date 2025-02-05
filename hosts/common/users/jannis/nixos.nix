{ config, lib', ... }:
{
  imports = [ ./common.nix ];

  sops.secrets.jannis-password.neededForUsers = true;
  users.mutableUsers = false;
  users.users.jannis.hashedPasswordFile = config.sops.secrets.jannis-password.path;

  home-manager.users.jannis = import (lib'.relativeToRoot "users/jannis/nixos.nix");
}
