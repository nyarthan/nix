let
  name = "tmux";
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
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        clock24 = true;
        focusEvents = true;
        keyMode = "vi";
        mouse = true;
        shortcut = "a";
        shell = lib.meta.getExe' pkgs.fish "fish";
      };
    };
  }
)
