{
  stdenv,
  fetchurl,
  lib,
}:
let
  version = "5.0.0";
  installerName = "Karabiner-DriverKit-VirtualHIDDevice-${version}.pkg";
in
stdenv.mkDerivation {
  inherit version installerName;
  pname = "karabiner-driver";

  src = fetchurl {
    url = "https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v${version}/${installerName}";
    sha256 = "sha256-hKi2gmIdtjl/ZaS7RPpkpSjb+7eT0259sbUUbrn5mMc=";
  };

  unpackPhase = ''
    mkdir -p $out
    cp -r $src $out/${installerName}
  '';

  meta = {
    description = "Karabiner driver for virtual mouse and keyboard on macos";
    license = lib.licenses.free;
    platforms = lib.platforms.darwin;
  };
}
