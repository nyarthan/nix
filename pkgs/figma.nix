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
    sha256 = "bQc9yesDoGTXSLKcpv0mG6zint48Ay6xifMeHfC+wbs=";
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
