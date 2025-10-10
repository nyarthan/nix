{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        name = "nix-config";

        packages = [
          pkgs.age
          pkgs.sops
          pkgs.ssh-to-age
          pkgs.mkpasswd
          pkgs.mask
        ];
      };
    };
}
