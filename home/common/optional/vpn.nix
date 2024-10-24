{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "vpn" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "Enables VPN";
    };

    config = lib.mkIf cfg.enable {
      home.packages = [
        pkgs.openvpn
      ];
    };
  }
)
