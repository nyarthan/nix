{ outputs, ... }:
{
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
    hostPlatform = "aarch64-darwin";
  };
}
