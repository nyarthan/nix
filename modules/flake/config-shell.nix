{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
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
