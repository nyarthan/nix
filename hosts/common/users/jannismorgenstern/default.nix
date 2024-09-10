{...}: {
  home-manager.users.jannismorgenstern = import ../../../../home/jannismorgenstern/darwin.nix;
  users.users.jannismorgenstern.home = "/Users/jannismorgenstern";
}
