{ ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      sandbox = false;
      trusted-users = [
        "root"
        "@admin"
      ];
      experimental-features = "nix-command flakes";
    };
  };

}
