{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "1.28.0";
  pname = "gather";
  appName = "Gather";
in
stdenv.mkDerivation {
  inherit version pname;
  src = fetchurl {
    url = "https://downloads.gather.town/desktop/Gather-1.28.0-universal.dmg";
    sha256 = "sha256-j7nZ/HlpEEYLHWRKKThfd/OKaC8zlZweOCqHtEmmYKM=";
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
