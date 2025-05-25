{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "2.25.14.77";
in
stdenv.mkDerivation {
  inherit version;
  pname = "whatsapp";

  src = fetchurl {

    url = "https://web.whatsapp.com/desktop/mac_native/release/?version=${version}&configuration=Release&branch=relbranch";
    sha256 = "sha256-DxKcHFozgmYTw8aijxhYW5WhBVHQNOqRoJOCEdGB6l8=";
  };

  buildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r WhatsApp.app $out/Applications/
  '';

  meta = {
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
  };
}
