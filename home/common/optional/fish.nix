{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.fish;
in
{
  options.custom.fish = {
    enable = lib.mkEnableOption "Enables fish";
  };

  config = {
    programs.fish = lib.mkIf cfg.enable {
      enable = true;
      shellInit = ''
        fish_add_path /opt/homebrew/Cellar/postgresql@16/16.4/bin
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
