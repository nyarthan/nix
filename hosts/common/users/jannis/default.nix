{configLib, ...}: {
  home-manager.users.jannis = import (configLib.relativeToRoot "home/jannis/darwin.nix");
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.users.jannis.home = "/Users/jannis";
}
