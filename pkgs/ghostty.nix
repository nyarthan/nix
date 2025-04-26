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
    cp -r ${appName}.app $out/Applications/
  '';

  meta = {
    description = appName;
    license = lib.licenses.free;
    platforms = lib.platforms.darwin;
  };
}
