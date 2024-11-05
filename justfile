alias help := default

default:
    @just --list

format:
    treefmt

format-check:
    @treefmt --fail-on-change --verbose

rebuild:
    @darwin-rebuild switch --flake ~/nix

check:
    @nix flake check
