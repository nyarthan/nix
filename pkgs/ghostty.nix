{
  stdenv,
  fetchurl,
  _7zz,
  lib,
}:
let
  version = "1.1.3";
  pname = "ghostty";
  appName = "Ghostty";
in
stdenv.mkDerivation {
  inherit version pname;

  src = fetchurl {
    url = "https://release.files.ghostty.org/${version}/Ghostty.dmg";
    sha256 = "sha256-ZOUUGI9UlZjxZtbctvjfKfMz6VTigXKikB6piKFPJkc=";
  };

  nativeBuildInputs = [ _7zz ];

  unpackPhase = ''
    7zz x -snld $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    mkdir -p $out/bin
    cp -r ${appName}.app $out/Applications/
    cp ${appName}.app/Contents/MacOS/ghostty $out/bin
  '';

  meta = {
    description = appName;
    license = lib.licenses.free;
    platforms = lib.platforms.darwin;
    mainProgram = "ghostty";
  };
}
