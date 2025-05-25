{
  pkgs ? import <nixpkgs> { },
}:
{
  raycast = pkgs.callPackage ./raycast.nix { };
  geist = pkgs.callPackage ./geist.nix { };
  karabiner-driver = pkgs.callPackage ./karabiner-driver.nix { };
  stirling-pdf = pkgs.callPackage ./stirling-pdf.nix { };
  ghostty = pkgs.callPackage ./ghostty.nix { };
  gather = pkgs.callPackage ./gather.nix { };
  figma = pkgs.callPackage ./figma.nix { };
  zen-browser = pkgs.callPackage ./zen-browser.nix { };
  whatsapp = pkgs.callPackage ./whatsapp.nix { };
  protonvpn = pkgs.callPackage ./protonvpn.nix { };
}
