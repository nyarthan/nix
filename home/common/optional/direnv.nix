inputs@{ lib', ... }:
lib'.mkCustomModule [ "direnv" ] inputs (
  { lib, cfg, ... }:
  {
    options = {
      enable = lib.mkEnableOption "Enables direnv";
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
