{...}: {
  home-manager.users.jannis = import ../../../../home/jannis/darwin.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.users.jannis.home = "/Users/jannis";
}
