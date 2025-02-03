{ lib', pkgs, ... }:
{
  users.users.jannis = {
    isNormalUser = true;
    description = "Primary Account";
    home = lib'.usersDirectory { inherit pkgs; } + "/jannis";
    # isHidden = false;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    group = "jannis";
  };

  users.groups.jannis = {};

  home-manager.backupFileExtension = "backup";

  programs.fish.enable = true;

  programs.git.config = {
    user.name = "Jannis Morgenstern";
    user.email = "jannis.n.morgenstern@gmail.com";
  };
}
