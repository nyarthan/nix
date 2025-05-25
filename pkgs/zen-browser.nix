{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "1.12.8b";
in
stdenv.mkDerivation {
  inherit version;
  pname = "zen-browser";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
    sha256 = "sha256-1M1HlR5DbBY2b5KOl+eJm8ITpKjyOoPvawLojeAAlik=";
  };

  buildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r Zen.app $out/Applications/
  '';

  meta = {
    license = lib.licenses.free;
    platforms = lib.platforms.darwin;
  };
}
