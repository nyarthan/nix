let
  name = "stirling-pdf";
in
{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ name ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib'.mkDefaultEnableOption name;
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.jdk21
        pkgs.git
        pkgs.python39
        pkgs.gnumake
        pkgs.gcc
        pkgs.automake
        pkgs.autoconf
        pkgs.libtool
        pkgs.pkg-config
        pkgs.zlib
        pkgs.leptonica
        pkgs.unpaper
        # pkgs.libreoffice
        pkgs.ocrmypdf
        pkgs.poppler_utils
        pkgs.stirling-pdf
      ];
    };
  }
)
