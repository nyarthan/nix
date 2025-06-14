let
  name = "ghostty";
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
      programs.ghostty = {
        enable = true;
        # package = pkgs.ghostty;
        settings = {
          theme = "3024 Night";
          window-decoration = "none";
          command = (lib.meta.getExe' pkgs.tmux "tmux");
        };
      };
    };
  }
)
