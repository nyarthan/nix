let
  name = "nushell";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    config,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      home.packages = [ pkgs.fzf ];
      programs.zoxide.enable = true;
      programs.atuin = {
        enable = true;
        enableNushellIntegration = true;
        enableFishIntegration = false;
      };
      programs.nushell = {
        enable = true;
        settings = {
          show_banner = false;
          buffer_editor = "/etc/profiles/per-user/jannis/bin/nvim";
        };
        envFile.text = ''
          $env.PATH = [
              $"($env.HOME)/.nix-profile/bin"
              $"/etc/profiles/per-user/($env.USER)/bin"
              "/run/current-system/sw/bin"
              "/nix/var/nix/profiles/default/bin"
              "/usr/local/bin"
              "/usr/bin"
              "/usr/sbin"
              "/bin"
              "/sbin"
          ]
        '';
      };
    };
  }
)
