{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.writeShellApplication {
        name = "nixfmt-wrapper";
        runtimeInputs = [
          pkgs.nixfmt-rfc-style
          pkgs.fd
        ];
        text = ''
          fd --extension nix --exec nixfmt {}
        '';
      };
    };
}
