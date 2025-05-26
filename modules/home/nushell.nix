let
  name = "nushell";
in
{ lib', ... }@inputs:
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
      programs.nushell = {
        enable = true;
        settings = {
          show_banner = false;
          buffer_editor = "/etc/profiles/per-user/jannis/bin/nvim";
        };
      };
    };
  }
)
