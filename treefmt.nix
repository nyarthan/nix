{ pkgs, config, ... }:
{
  inherit (config.flake-root) projectRootFile;
  package = pkgs.treefmt;
  programs.nixfmt.enable = true;
  programs.yamlfmt.enable = true;
}
