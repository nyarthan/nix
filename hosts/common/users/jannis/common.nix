{ lib', pkgs, ... }:
{
  users.users.jannis = {
    # isNormalUser = true;
    description = "Primary Account";
    home = lib'.usersDirectory { inherit pkgs; } + "/jannis";
    # isHidden = false;
    shell = pkgs.nushell;
    # extraGroups = [ "wheel" ];
    # group = "jannis";

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./keys/id_ed25519.pub)
    ];
  };

  users.groups.jannis = { };

  home-manager.backupFileExtension = "backup";

  # programs.fish.enable = true;
}
