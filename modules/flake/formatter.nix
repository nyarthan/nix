{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.writeShellApplication {
        name = "nixfmt-wrapper";
        runtimeInputs = [
          pkgs.nixfmt
          pkgs.fd
        ];
        text = ''
          fd --extension nix --exec nixfmt {}
        '';
      };
    };
}
