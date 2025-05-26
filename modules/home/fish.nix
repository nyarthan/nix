let
  name = "fish";
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
      home.packages = [ pkgs.carapace ];
      programs.fish = lib.mkIf cfg.enable {
        enable = true;
        shellInit = ''
          fish_add_path /opt/homebrew/Cellar/postgresql@16/16.4/bin
          set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
          carapace _carapace | source
        '';
        functions = {
          docker = lib.mkIf config.custom.docker.enable {
            body = ''
              function start_docker_if_needed
                if not test -S ~/.colima/default/docker.sock
                  echo "Starting Colima..."
                  colima start
                end
              end

              start_docker_if_needed
              command docker $argv
            '';
          };
        };
      };
    };
  }
)
