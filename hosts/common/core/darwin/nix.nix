{ ... }:
{
  nix = {
    settings = {
      sandbox = false;
      trusted-users = [
        "root"
        "@admin"
      ];
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
  };

}
