let
  name = "starship";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    cfg,
    lib,
    config,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      programs.starship = {
        enable = true;

        enableBashIntegration = lib.mkIf config.custom.bash.enable true;
        enableFishIntegration = lib.mkIf config.custom.fish.enable true;
        enableNushellIntegration = lib.mkIf config.custom.nushell.enable true;

        settings = {
          add_newline = false;
          character = {
            success_symbol = "[󱞩](bold green)";
            error_symbol = "[󱞩](bold red)";
          };

          nix_shell = {
            format = "󰇙 [$symbol $name $state ]($style)";
            symbol = "󱄅";
            impure_msg = "[\\(impure\\)](yellow)";
            pure_msg = "[\\(pure\\)](green)";
            unknown_msg = "[\\(unknown\\)](yellow)";
          };
        };
      };

      home.packages = [ pkgs.nodejs_20 ];
    };
  }
)
