let
  name = "bash";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.bat
      ];

      programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          export PS1='$(starship prompt)'
          export MANPAGER='sh -c "col -bx | bat -l man -p"'
          export MANROFFOPT="-c";
        '';
        historyFile = "$HOME/.bash_history";
        historyIgnore = [
          "ls"
          "cd"
          "exit"
          "clear"
          "nvim"
          "history"
          "zellij"
        ];
        shellAliases = {
          ll = "ls -l";
          la = "ls -la";
          ".." = "cd ..";
        };
      };
    };
  }
)
