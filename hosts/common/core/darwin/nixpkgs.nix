{ ... }:
{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
    hostPlatform = "aarch64-darwin";
  };
}
