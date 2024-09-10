{...}: {
  home-manager.users.jannis = import ../../../../home/jannis/darwin.nix;
  users.users.jannis.home = "/Users/jannis";
}
