{
  stdenv,
  fetchurl,
  undmg,
  lib,
}:
let
  version = "4.8.0";
in
stdenv.mkDerivation {
  inherit version;
  pname = "protonvpn";

  src = fetchurl {

    url = "https://protonvpn.com/download/macos/${version}/ProtonVPN_mac_v${version}.dmg";
    sha256 = "sha256-UXB5sOy5QDGErtiDYz6XEn88ewBs8PKC6w4F5dYzK4A=";
  };

  buildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r ProtonVPN.app $out/Applications/
  '';

  meta = {
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
  };
}
