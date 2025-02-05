{ lib', ... }:
{
  imports = [ ./common.nix ];
  home-manager.users.jannis = import (lib'.relativeToRoot "users/jannis/nixos.nix");
}
