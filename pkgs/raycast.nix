{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "1.82.5";
in
stdenv.mkDerivation {
  inherit version;
  pname = "raycast";

  src = fetchurl {
    url = "https://releases.raycast.com/releases/${version}/download";
    sha256 = "sha256-JqnFvtLrFEnuAqpBtrSlG++FwioDdjdjvgeTTo1wnv0=";
  };

  buildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r Raycast.app $out/Applications/
  '';

  meta = {
    description = "Your shortcut to everything";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
  };
}
