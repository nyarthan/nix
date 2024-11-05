let
  name = "direnv";
in
inputs@{ lib', ... }:
lib'.mkCustomModule [ name ] inputs (
  { lib, cfg, ... }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
  }
)
