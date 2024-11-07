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
      enable = lib.mkEnableOption "bash";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.blesh
      ];

      programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          # source ${pkgs.blesh}/share/blesh/ble.sh --rcfile "$HOME/.blerc"
          # [[ ! ''${BLE_VERSION-} ]] || ble-attach
          export PS1='$(starship prompt)'
        '';
        historyFile = "$HOME/.bash_history";
        historyIgnore = [
          "ls"
          "cd"
          "exit"
          "clear"
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
