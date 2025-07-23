# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable

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
      home.file.".gitconfig".text = ''
        [init]
          defaultBranch = master

        [user]
          name = Jannis Morgenstern
          email = jannis.n.morgenstern@gmail.com

        [filter "lfs"]
          clean = git-lfs clean -- %f
          smudge = git-lfss smudge -- %f
          process = git-lfs filter-process
          required = true

        [rerere]
          enabled = true


      '';

      programs.git = {
        enable = true;
      };
    };
  }
)
