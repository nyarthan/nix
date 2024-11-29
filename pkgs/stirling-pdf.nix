{
  pkgs,
  stdenv,
  fetchgit,
  lib,
}:
let
  pname = "stirling-pdf";
  version = "0.33.1";
in
stdenv.mkDerivation {
  inherit version pname;

  src = fetchgit {
    url = "https://github.com/Stirling-Tools/Stirling-PDF.git";
    rev = "fd906d36dd8204e2841b103acffba9c851623d26";
    sha256 = "sha256-Pneh9PszE41HULmDq32KVYkSIMDe4kUR143glFXRIQU=";
  };

  nativeBuildInputs = [
    pkgs.gradle_7
    pkgs.jdk21
    pkgs.makeWrapper
  ];

  dontConfigure = true;

  GRADLE_USER_HOME = "$(mktemp -d)";

  buildPhase = ''
    export JAVA_HOME=${pkgs.jdk21}
    gradle --no-daemon build
  '';

  __noChroot = true;

  installPhase = ''
    mkdir -p $out/{bin,lib,share/${pname}}

    cp build/libs/Stirling-PDF-${version}.jar $out/lib/

    makeWrapper ${pkgs.jdk21}/bin/java $out/bin/stirling-pdf \
      --add-flags "-jar $out/lib/Stirling-PDF-${version}.jar"
      
    cp -r scripts $out/share/${pname}/
  '';

  meta = {
    description = "Locally hosted web application that allows you to perform various operations on PDF files";
    license = lib.licenses.free;
    platforms = lib.platforms.darwin;
  };
}
