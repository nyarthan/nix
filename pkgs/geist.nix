{
  stdenv,
  fetchzip,
  lib,
}:
let
  version = "1.4.0";
in
stdenv.mkDerivation {
  inherit version;
  pname = "geist";

  src = fetchzip {
    url = "https://github.com/vercel/geist-font/releases/download/${version}/Geist-v${version}.zip";
    sha256 = "sha256-JqnFvtLrFEnuAqpBtrSlG++FwioDdjdjvgeTTo1wnv0=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/doc/geist

    mv ttf/*.ttf $out/share/fonts/truetype
    mv otf/*.otf $out/share/fonts/opentype
    mv OFL.txt $out/share/doc/geist/LICENSE
  '';

  meta = {
    homepage = "https://vercel.com/font";
    description = "Geist is a typeface made for developers and designers, embodying Vercel's design principles of simplicity, minimalism, and speed, drawing inspiration from the renowned Swiss design movement.";
    changelog = "https://github.com/vercel/geist-font/releases";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
