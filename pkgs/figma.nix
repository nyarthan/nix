{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "latest";
  pname = "figma";
  appName = "Figma";
in
stdenv.mkDerivation {
  inherit version pname;

  src = fetchurl {
    url = "https://desktop.figma.com/mac-installer/Figma.dmg";
    sha256 = "UMD1dDYxUSE6wzj8HS1RRGrvqavSt4i+JCbkqE1Sruc=";
  };

  nativeBuildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r ${appName}.app $out/Applications/
  '';

  meta = {
    description = appName;
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
  };
}
