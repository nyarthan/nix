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
      download-buffer-size = 536870912; # 512 MB
    };
    optimise.automatic = true;
  };

}
