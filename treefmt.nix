{
  config,
  pkgs,
  globignore,
  ...
}:
{
  inherit (config.flake-root) projectRootFile;
  package = pkgs.treefmt;
  settings = {
    global.excludes =
      builtins.fromJSON (
        builtins.readFile (
          pkgs.runCommand "globignore-list" { } ''
            ${globignore}/bin/globignore --cwd ${./.}  > $out
          ''
        )
      )
      ++ [
        ".envrc"
        "assets/**"
      ];
    formatter = {
      "justfile" = {
        command = "${pkgs.just}/bin/just";
        options = [
          "--unstable"
          "--fmt"
          "--check"
          "--justfile"
        ];
        includes = [ "justfile" ];
      };
    };
  };
  programs = {
    nixfmt.enable = true;
    mdformat.enable = true;
    yamlfmt.enable = true;
    taplo.enable = true;
  };
}
