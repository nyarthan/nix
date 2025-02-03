let
  name = "git";
in
{ lib', ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib'.mkDefaultEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      programs.git = {
        userEmail = "jannis.n.morgenstern@gmail.com";
        userName = "Jannis Morgenstern";
        enable = true;
        lfs.enable = true;
        maintenance.enable = true;
      };
    };
  }
)
