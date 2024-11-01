{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.bash;
in
{
  options.custom.bash = {
    enable = lib.mkEnableOption "Enables bash";
  };

  config = {
    home.packages = [
      pkgs.blesh
    ];

    programs.bash = lib.mkIf cfg.enable {
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
