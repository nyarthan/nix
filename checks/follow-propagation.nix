{
  pkgs,
  system,
  inputs,
  ...
}:
pkgs.runCommandLocal "followPropagation"
  {
    src = ../.;
    nativeBuildInputs = [ inputs.nix-auto-follow.packages.${system}.default ];
  }
  ''
    cp $src/flake.lock .
    auto-follow -c | grep -q "All ok!" || exit 1
    mkdir $out
  ''
